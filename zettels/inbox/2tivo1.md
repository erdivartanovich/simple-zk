#idea #shell #zsh
2026-07-14 10:30

# A heredoc needs no command — redirect it straight to a file

A heredoc is stdin, and a redirection can stand alone without a command. So the shell
can append (or write) a here-document directly, no `cat`/`tee` needed:

    >> ~/.config/zsh/aliases.zsh <<'EOF'
    alias gpo='git push origin'
    alias ga='git add .'
    EOF

`>>` appends, `>` overwrites; quote the delimiter (`<<'EOF'`) to write the lines verbatim.

Why prefer this over `cat <<EOF >> file`: there's no command to go wrong — no alias to
shadow it (e.g. `cat` aliased to `bat --color=always`, which injects escape codes), no
extra process. The shell just opens the file and drops the block in. Fewer moving parts.
