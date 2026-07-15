---
date_created: 2026-07-10 01:24
---

# Vim - Pipe shell command output to vim quickfix list
#source

```sh
grep -rn "TODO" file-or-path | nvim -q -
```

The trailing - tells nvim to accept `stdin` directly as the quickfix targetfile
