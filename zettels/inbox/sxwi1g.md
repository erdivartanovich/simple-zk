---
date_created: 2026-07-14 09:00
---

# A quoted heredoc delimiter decides whether the body is data or code
#idea #zsh #shell

`cat >> file <<EOF ... EOF` appends a block, but the *delimiter's quoting* silently
changes what gets written:

- `<<EOF`   (unquoted) -> shell expands `$var`, `$(cmd)`, backticks IN the body FIRST,
             then writes the result. The body is treated as code.
- `<<'EOF'` (quoted)   -> every line written verbatim. The body is treated as data.

This is the trap when generating config: appending `alias drmi='... $(docker image ls -aq)'`
with an unquoted heredoc runs `docker image ls` at write-time and bakes in the output.
Quote the delimiter whenever the text contains literal `$`, `$()`, or backticks.

Two more knobs: `>>` appends / `>` truncates; `<<-EOF` strips leading TABS (not spaces)
so the heredoc can be indented inside a function while writing flush-left output.
