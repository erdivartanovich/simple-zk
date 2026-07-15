#source
2026-07-10 03:14

---

# nvim cheatsheet: git suite


#nvim #cheatsheet

Plugin-free git commands (lua/git.lua), all quickfix-based.

| Command | Short | Does |
|---|---|---|
| `:Gstatus` | `:GS` | status --porcelain → quickfix |
| `:Glog [args]` | `:GL` | last 20 commits (`--all`, `-50`, ...) |
| `:Gdiff [args]` | `:GD` | every changed line → quickfix (`--staged`, `HEAD~1`) |
| `:Gvdiff [rev]` | `:GV` | current buffer side-by-side vs index, or vs rev (`HEAD~2`) |
| `:GReview` | | changed files → quickfix, jump to first |
| `:Gblame` / `:5Gblame` / `:2,10Gblame` | `:GB` | raw blame in split (%, line, range; args: `-w`); q closes |
| `:Ggrep pat` | `:GG` | git grep → quickfix |
| `:Undotree` | | toggle undo history panel |

Whole-tree visual diff from shell: `git difftool -d [rev]` (nvim.difftool: quickfix of A/D/M/R files, side-by-side per file, rename detection).

Staging without gitsigns: `git add -p` in a terminal.

Navigate results: `<M-j>` / `<M-k>` next/prev, `<M-q>` close.

