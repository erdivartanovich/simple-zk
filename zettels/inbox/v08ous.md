#source
2026-07-10 03:14

---

# nvim cheatsheet: LSP and completion


#nvim #cheatsheet

Native vim.lsp.enable, servers in lsp/<name>.lua (lua_ls, ts_ls, denols, angularls, astro, tailwindcss, marksman, bashls). Deno vs Node roots auto-detected.

| Key | Does |
|---|---|
| `gd` / `gD` | definition / declaration |
| `grn` `gra` `grr` `gri` | rename, code action, references, implementation (builtin) |
| `gl` | float diagnostic under cursor |
| `gO` / `gW` | document / workspace symbols → loclist |
| `<leader>ca` | code action |
| `<leader>cs` | TS source actions (organize imports etc.) |
| `<leader>th` | toggle inlay hints |
| `<leader>ql` / `qq` | diagnostics → loclist / quickfix |
| `K` | hover (builtin) |

Completion: native vim.lsp.completion, autotriggers while typing.
`<C-n>`/`<C-p>` select, `<C-y>` accept, `<C-e>` cancel. Fuzzy matching on (completeopt).
Missing server? Binary must be on PATH (no mason).

