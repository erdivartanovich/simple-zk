---
date_created: 2026-07-12 21:15
---

# Git - Open all STAGED files
#source #git #nvim

```bash
nvim $(git diff --name-only --cached)
```
