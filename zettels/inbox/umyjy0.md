---
date_created: 2026-07-10 03:14
---

# nvim cheatsheet: quickfix workflow
#source

#nvim #cheatsheet

Quickfix is the universal interface: git, find, grep, diagnostics, messages all land there.

- `<M-j>` / `<M-k>` — cnext / cprev (works from any window)
- `<M-q>` — close quickfix + loclist
- `<leader>qm` / `:Msg` — :messages → quickfix
- `<leader>ql` / `<leader>qq` — diagnostics → loclist / quickfix
- `:copen` `:cold` `:cnew` — reopen, older list, newer list (history!)
- `:cdo s/a/b/g | update` — run Ex cmd on every entry
- `:cfdo` — once per file
- `:packadd cfilter` then `:Cfilter pat` / `:Cfilter! pat` — keep/drop entries
- Panels render on the lighter Panel tier; current entry = teal QuickFixLine

Feeders: :Gstatus :Gdiff :GReview :Fd :Grep :Ggrep :Gblame :Msg
