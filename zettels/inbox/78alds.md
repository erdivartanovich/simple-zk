---
date_created: 2026-08-04 19:21
---

## Git - How to clean rebase from upstream
In forked repository scenario.

#source

After sync with upstream (from gh dashboard):

```bash
git fetch origin master                 # freshest fork master -> origin/master
git checkout your-feature-branch
git rebase origin/master                # replay your 3 commits onto it
git log --oneline origin/master..HEAD   # verify: only YOUR commits
git push --force-with-lease origin your-feature-branch
```

### Important Rules:

- No bare git pull/git pull --rebase on the feature branch — it pulls from the branch's own upstream (your fork branch). Sync only via git rebase origin/master.
- --force-with-lease, not --force — rebasing rewrites commits, so the push must force; the lease refuses if the fork branch moved under you.
- Verify before pushing: git log origin/master..HEAD should list exactly your 3 commits. If it shows upstream commits, you're about to push the same mess again.

### Recommended setup:

- Add the real upstream remote for sync from canonical master:
```bash
git remote add upstream git@github.com:neovim/neovim.git
```
- Sync recipe afterward (for future sessions):
```bash
git fetch upstream master
git rebase upstream/master        # on your feature branch
git push --force-with-lease origin <your-feature-branch>
```
