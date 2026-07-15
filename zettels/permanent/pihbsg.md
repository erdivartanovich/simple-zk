#source #shell #zsh #bash
2026-07-14 11:00

# Here-documents (heredocs) in the shell

A **here-document** is inline text supplied to a command's standard input, introduced by
`<<DELIM` and terminated by a line containing only `DELIM`. It is an *input* mechanism —
distinct from redirection, which moves a command's *output*.

## Syntax

    command <<DELIM
    ...body lines...
    DELIM

- `<<DELIM`  — read the body until a line that is exactly `DELIM` (conventionally `EOF`).
- `<<-DELIM` — same, but strip **leading tabs** (not spaces) from body and terminator, so
  the block may be indented inside a function or script while producing flush-left text.

## Delimiter quoting — the body is data or code

Whether the shell expands the body before delivering it depends on quoting the delimiter:

- `<<'EOF'` (quoted)   — body written **verbatim**; `$var`, `$(...)`, backticks are literal.
- `<<EOF`   (unquoted) — body is **expanded first** by the *current* shell, then delivered.

Quote it when writing config or code that contains literal `$`/`$()`; leave it unquoted
only to deliberately bake in a locally-computed value.

## Two uses, by what receives the input

1. **Write a file** — pair the heredoc with output redirection. A heredoc needs no command:
   the shell can append the block straight to a file (`>> file <<'EOF'`). Adding `cat`/`tee`
   only introduces a process that can be shadowed by an alias.
2. **Execute a block** — feed the heredoc to an interpreter (`bash`, `ssh host`, `sudo
   bash`, `docker exec -i c bash`, `python3`). Each body line is run. For remote/root/
   container targets, quote the delimiter so the **target** performs expansion, not the
   local shell.

## Related detail (network references)

Refined atomic points from this concept live as idea notes:
`sxwi1g` (quoted vs unquoted = data vs code), `2tivo1` (a heredoc needs no command),
`eqygem` (heredoc into an interpreter executes a block), `ettqbz` (an aliased `cat` —
`bat --color=always` — corrupts redirected output with escape codes).
