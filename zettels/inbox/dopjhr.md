---
date_created: 2026-08-13 10:47
---

# Trimming Neovim startup: the treesitter install loop, and how to measure it
#idea #neovim #treesitter #performance

My Neovim config took 54 milliseconds to start on an idle machine. That is not
slow enough to notice, but I wanted to know where the time was going. One loop in
my Treesitter setup turned out to be responsible for 60% of it, and that loop was
not accomplishing anything.

The pattern is common enough that I suspect most people who set up Treesitter by
hand have written the same thing.

## The loop that looks completely reasonable

[Treesitter](https://neovim.io/doc/user/treesitter.html) is Neovim's parsing
engine. It reads your code into a syntax tree, which is what gives you accurate
highlighting, folding, and text objects. Every language needs its own **parser**,
a small compiled library that has to be installed once before it can be used.

The [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) plugin
manages those parsers. Its `main` branch has no `ensure_installed` option — that
setting belonged to the older `master` branch, which is still what most tutorials
show. So if you follow a current guide, you get an `install()` function and you
are left to call it yourself.

Here is what I wrote:

```lua
local ts = require 'nvim-treesitter'
local parsers = { 'astro', 'bash', 'c', --[[ ...38 more... ]] 'yaml' }

for _, parser in ipairs(parsers) do
    ts.install(parser)
end
```

That reads perfectly sensibly. You have a list of names, and you have a function
that takes one name, so you loop over the list. Every parser is already on disk
after the first run, so you would expect the loop to be nearly free.

It was not free. It cost 32 ms on every launch.

## Measure it with --startuptime

Neovim ships with a flag that logs where startup time goes:

```sh
nvim --headless --startuptime start.log -c 'qa!'
```

`--headless` skips the UI so the numbers stay repeatable, and `-c 'qa!'` quits as
soon as startup finishes. Two details about that log will cost you an afternoon
if nobody warns you first.

**The log appends, it does not overwrite.** This is documented in
`:h --startuptime`, and it is very easy to miss. Run the command five times and
you get five runs stacked inside one file, silently. Delete the log between runs.

**The last line is blank.** That means `tail -1 start.log` hands back an empty
string, which looks exactly like the command failed. Grep for the closing marker
instead:

```sh
grep 'NVIM STARTED' start.log | awk '{print $1}'
```

Run it six or seven times and read the range rather than one number. The first
run is always the slowest, because the filesystem cache has not warmed up yet.

## Read the three columns correctly

Log lines that load a Lua module carry three numbers, and the middle one is the
one people misread:

```
030.274  020.070  020.070: require('child')
030.282  025.584  005.515: require('parent')
```

- The **first** number is the clock, in milliseconds since Neovim started.
- The **second** is the total cost of that module, including everything it loads.
- The **third** is the time spent inside that module alone.

Rather than trust my reading of the docs, I built a test for it. I wrote a module
`child` that burns 20 ms, and a module `parent` that burns 5 ms of its own work
and then requires `child`. The output above is the real result: `parent` reports
25.584 ms total against 5.515 ms self, which is its own 5.5 plus the 20.07 it
inherited.

That difference is what points you at the real cost. When a module shows a large
total and a tiny self time, the module is not slow — something it loads is.

## Get a baseline before you blame yourself

Your config is only answerable for the gap between a bare Neovim and yours, so
measure the bare one:

```sh
nvim --clean --headless --startuptime clean.log -c 'qa!'
```

`--clean` launches with no config and no plugins at all. Mine came in around
6 ms, which meant roughly 48 ms of my 54 ms was genuinely mine.

## Sort the log by cost

Now rank the modules by that second column, the cumulative one:

```sh
grep -E '^[0-9]' start.log \
  | awk 'NF>=3 && $2 ~ /^[0-9]/ {c=$2; $1=""; $2=""; printf "%8.3f %s\n", c, $0}' \
  | sort -rn | head -15
```

The top of my list:

```
41.262  000.061: sourcing init.lua
33.963  002.851: require('treesitter')
 3.994  000.658: require('lsp')
```

My whole `init.lua` accounted for 41 ms, but only 0.061 ms of that was its own
code. Almost all of it sat under `require('treesitter')` at 33.963 ms, of which
just 2.851 ms was the module's own work. The expense was in what it called.

The log also showed `nvim-treesitter.parsers` being loaded 42 times, which is
once per parser in my list plus one. That was the clue worth chasing.

## Time the suspect line directly

The log names the expensive module, not the expensive line. For that, time the
code yourself with `vim.uv.hrtime()`, which returns nanoseconds:

```lua
local t0 = vim.uv.hrtime()
for _, p in ipairs(parsers) do ts.install(p) end
local t1 = vim.uv.hrtime()
print(string.format('install loop: %.1f ms', (t1 - t0) / 1e6))
```

Measured across 41 parsers that were all already installed:

- The `install()` loop, one call per parser: **32.2 ms**
- One `install()` call passed the whole list: **1.8 ms**
- `ts.get_installed('parsers')`, which only reads what is on disk: **0.1 ms**

Forty-one separate calls cost roughly eighteen times more than a single call
handling the same forty-one names. Each call repeats setup work that the batch
form does once, which is what those 42 module loads were.

## The fix

Since `install()` accepts a table, the batch call on its own would have brought
it to 1.8 ms. Comparing against what is already installed does better, because
then the normal case skips installing entirely:

```lua
local installed = {}
for _, parser in ipairs(ts.get_installed 'parsers') do
    installed[parser] = true
end

local missing = vim.tbl_filter(function(parser)
    return not installed[parser]
end, parsers)

if #missing > 0 then
    ts.install(missing)
end
```

Adding a new language to `parsers` still installs it on the next launch, because
the new name will not be in the `installed` set. What changed is the steady state:
every launch after the first now costs a single directory read.

## Compare the two versions back to back

Hours later I re-ran the benchmark and the fixed config reported 37 ms rather
than 20.5 ms. Nothing in the config had changed. The machine had picked up a load
average of 3.5, and bare Neovim had drifted from 6 ms to 11 ms right alongside it.

A startup number only means something next to a measurement taken under the same
conditions. So keep both versions of the file and alternate between them inside
one loop, instead of trusting a figure you wrote down yesterday:

```sh
# two config trees, identical except for the line under test
mkdir -p /tmp/ab/before /tmp/ab/after
cp -r ~/.config/nvim /tmp/ab/before/nvim
cp -r ~/.config/nvim /tmp/ab/after/nvim
git show HEAD~1:nvim/lua/treesitter.lua > /tmp/ab/before/nvim/lua/treesitter.lua

for i in $(seq 1 10); do
  for arm in before after; do
    rm -f /tmp/ab/$arm.log
    XDG_CONFIG_HOME=/tmp/ab/$arm nvim --headless \
      --startuptime /tmp/ab/$arm.log -c 'qa!' >/dev/null 2>&1
    grep 'NVIM STARTED' /tmp/ab/$arm.log | awk -v a=$arm '{print a, $1}'
  done
done
```

Override `XDG_CONFIG_HOME` and nothing else. Leave `XDG_DATA_HOME` where it is,
because that is where your installed parsers and plugins actually live. Point it
at a fresh directory and `install()` will conclude that everything is missing and
start downloading.

## The numbers

Ten interleaved runs of each version, on the same busy machine:

| | Before | After |
|---|---|---|
| Startup, median | 95.1 ms | 34.9 ms |
| Startup, fastest | 70.4 ms | 25.9 ms |

Earlier, on an idle machine, the same pair came in at 54 ms and 20.5 ms against a
6 ms bare-Neovim floor. The absolute figures move around with load, but the
reduction holds at roughly 63% either way, and that ratio is the number worth
quoting to anyone.

Here is the module-level split, taken from the idle run:

| | Before | After |
|---|---|---|
| `require('treesitter')`, cumulative | 33.963 ms | 3.072 ms |
| `require('treesitter')`, self | 2.851 ms | 0.607 ms |

The next largest entries after Treesitter were `vim.lsp` at 2.8 ms and shada at
1.9 ms, so there is not a great deal left to win.

Speed is worthless if the feature broke, so I checked that Treesitter still
attaches and still folds:

```sh
nvim --headless file.lua -c 'lua
  local b = vim.api.nvim_get_current_buf()
  print(vim.treesitter.highlighter.active[b] ~= nil, vim.wo.foldexpr)' -c 'qa!'
```

## What I took away

**A loop around a single-item function deserves a second look.** Plenty of APIs
accept a list precisely because the per-call setup is expensive, so it is worth
reading the signature before writing the loop.

**Work that finds nothing to do is still work.** All 41 of my calls existed to
confirm that all 41 parsers were already present, and that confirmation cost
32 ms.

The third one is really about the tool. Self time and total time are what make
the startup log worth reading. Without that split I would have seen 41 ms sitting
against `init.lua`, with twenty required modules underneath it and no way to
choose between them.

None of this made Neovim feel different, and that is worth saying plainly. It
opened instantly at 54 ms and it still opens instantly at 20.5 ms. The reason to
bother is that `--startuptime`, `--clean`, and `hrtime()` work on every other line
in the config too, and now I know which lines to point them at.
