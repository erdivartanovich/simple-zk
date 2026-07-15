---
date_created: 2026-07-14 10:00
---

# An aliased `cat` can corrupt redirected output with color codes
#idea #shell #zsh #gotcha

`cat` is aliased to `bat --style=plain --color=always`. In an interactive shell,
`cat << EOF >> file` therefore runs *bat*, and `--color=always` emits ANSI escape
codes (`^[[37m … ^[[0m`) EVEN when the output is redirected to a file — because
`always` overrides the usual "disable color when not a TTY" behavior. The file ends
up with escape bytes wrapping each line, quietly breaking whatever reads it.

Lesson: aliases apply in interactive shells, so a bare command name may not be the
program you think. Bypass an alias with `\cat`, `command cat`, or `/bin/cat`.

Cleanest fix here: drop the command entirely — a heredoc needs no command to write a
file: `>> file <<'EOF' … EOF` lets the shell append the block directly.
