#source
2026-07-12 21:15

---

#git #nvim

# Git - Open all STAGED files

```bash
nvim $(git diff --name-only --cached)
```
