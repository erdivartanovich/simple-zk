---
date_created: 2026-07-23 13:15
---

# Insert registers and buffer text into vim cmdline with C-r
#idea #nvim

In command-line mode, `<C-r>` pastes any register: `<C-r>"` last yank, `<C-r>+`
clipboard, `<C-r>/` last search, `<C-r>%` filename, `<C-r>=` an evaluated expression.

The `<C-r><C-…>` variants pull from the buffer instead of a register:

- `<C-r><C-w>` word under cursor, `<C-r><C-a>` WORD (whitespace-delimited)
- `<C-r><C-f>` filename under cursor (`<C-r><C-p>` expanded via `'path'`)
- `<C-r><C-l>` the whole line

There is no direct grab for a visual selection — the idiom is *yank, then paste the
register*: select, `y`, then `<C-r>"` in the cmdline (with visual `y` remapped to
`"+y`, `<C-r>+` also works).
