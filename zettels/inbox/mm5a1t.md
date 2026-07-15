#source
2026-07-10 19:01

---

# nvim cheatsheet: netrw file ops


#nvim #cheatsheet

Open: `:Ex` (cwd of buffer) / `:Vex` / `:Sex` / `:Lex` — inside: `<CR>` open, `v` vsplit, `o` split, `t` tab, `p` preview, `-` up-dir, `i` cycle list styles, `d`/`%` new dir/file, `R` rename, `gh` toggle dotfiles.

Mark workflow (custom feedback: every op echoes Target / Files / Status — also in :Msg history):

| Key | Does | Status shown |
|---|---|---|
| `mf` | toggle mark on cursor file | marked (list = current selection) |
| `mr` | mark by pattern (prompts, e.g. `*.txt`) | marked (regexp) — shows what matched |
| `mt` | set copy/move target (cursor dir, or cwd on a file) | target set |
| `mc` | copy marked → target | copied |
| `mm` | move marked → target | moved |
| `mu` | clear all marks | unmarked all |
| `D` | delete marked/cursor file (per-file y/n/a prompt) | deleted, survivors tagged (kept) |

Lifecycle: select (`mf`/`mr`) → aim (`mt`) → act (`mc`/`mm`/`D`) → clear (`mu`).

Notes:
- feedback implemented via g:Netrw_UserMaps in keymaps.lua (survives netrw re-renders; buffer-local overrides don't)
- remote (scp/ftp) delete: use `<Del>` — the D wrapper is local-only
- other useful marks: `me` edit marked, `md` diff marked (≤3), `mx` run command on marked

