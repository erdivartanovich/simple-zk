---
date_created: 2026-07-12 21:17
---

# Git - Open all UNTRACKED files
#source #git #nvim

```bash
nvim $(git ls-files --others --exclude-standard)
```
