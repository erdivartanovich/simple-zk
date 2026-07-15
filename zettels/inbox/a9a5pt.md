#source
2026-07-12 21:17

---

#git #nvim

# Git - Open all UNTRACKED files


```bash
nvim $(git ls-files --others --exclude-standard)
```
