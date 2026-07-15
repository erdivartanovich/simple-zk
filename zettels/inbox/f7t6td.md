#source
2026-01-22 17:54

---

#git #sh

# Git Clean / Delete untrack files

```sh
git clean -xf
```

vs 

```sh
git ls-files --others --exclude-standard -z | xargs -0 rm
```

⚠️ The Hidden Danger of git clean -xf
The -x flag tells Git to ignore your .gitignore rules, thus will wipe:
- untracked files
- all files listed in .gitignore

## If You want a total "factory reset" of your repository.
Safe recommendation: Instead of -xf, use 
git clean -df 
(keeps your ignored files safe but deletes
un-ignored files and folders). 

## Dry Run Pro-Tip: Always test what will be deleted first by running

`git clean -nd` or `git clean -nxf`. 

> The -n flag previews the deletion without touching a single file.
