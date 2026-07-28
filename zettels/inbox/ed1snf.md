---
date_created: 2026-07-26 17:10
---

# Shell - which vs command -v vs hash
#source #linux

`which`, `command -v` and `hash` are utilities that can be used to check if
a program is exists.

`command -v` is significantly better and safer than `which`.
The `which` command is an obsolete external utility, 
while `command -v` and `hash` is a modern shell built-in designed specifically for script stability.


## When to Choose command -v (Best for General Scripts)
It is POSIX standard: It works flawlessly across Bash, Zsh, Dash (Ubuntu's default script runner), and macOS.
It handles aliases and functions: It returns success even if the command is mapped to a custom shell function.
Safer default: It only checks the command; it does not alter the shell's environment.

## When to Choose hash (Best for Performance Loops)
It is faster on repeated hits: It checks the shell's internal cache memory rather than scanning your disk directories.
Side effect: Running hash command actively caches the binary path. If you plan to call that command hundreds of times right after the check, hash primes the system for it.

## Conclusion
Prefer `command -v` for script portability, and `hash` for micro-optimization inside tight loops.
For 99% of scripts, `command -v` is the correct modern standard.

