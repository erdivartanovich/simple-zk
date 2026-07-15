#idea
2026-07-14 00:01

# git diff answers three different questions depending on the baseline

The confusion around "what did I change?" dissolves once you see that `git diff`
is always comparing two of three snapshots: working tree, index (staging area),
and HEAD (last commit).

- `git diff`          -> working tree vs index  -> what's UNSTAGED
- `git diff --staged` -> index vs HEAD          -> what's STAGED
- `git diff HEAD`     -> working tree vs HEAD    -> BOTH (everything since last commit)

Corollary that trips people up: a *fully staged* file does NOT show in plain
`git diff`, because its working tree matches the index. That's the whole reason
`git diff HEAD` exists.

`git status -s` is the map: two columns per file -- left = index (staged),
right = working tree (unstaged), `??` = untracked. None of the diff commands
show untracked files; list those with the plumbing command
`git ls-files --others --exclude-standard` (stable, pipe-safe).
