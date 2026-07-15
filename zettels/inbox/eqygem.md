#idea #shell #zsh #ssh
2026-07-14 09:30

# Pipe a heredoc into an interpreter to run a multiline command block

A heredoc is just stdin. Point it at `cat` and you build a file; point it at a *shell*
(or any interpreter) and the block gets executed line by line. This is the clean way to
run a batch of commands as one unit — locally, as root, on a remote host, or in a container.

```sh
# run a local block
bash <<'EOF'
mkdir -p /tmp/demo && cd /tmp/demo
for i in 1 2 3; do touch "file$i"; done
echo "made $(ls | wc -l) files"
EOF
```

Delimiter quoting decides WHERE expansion happens (see the sibling note on quoted vs
unquoted delimiters):

- `<<'EOF'` (quoted)   -> `$var` / `$(...)` evaluated by the TARGET shell when it runs.
- `<<EOF`   (unquoted) -> evaluated LOCALLY first, then the result is sent.

Useful patterns:

```sh
# batch commands on a remote host over ONE ssh connection
# quoted -> $(df) runs on the server, not locally
ssh user@server <<'EOF'
cd /var/www && git pull
systemctl restart nginx
echo "free space: $(df -h / | tail -1)"
EOF

# unquoted -> inject a LOCAL value into the remote block
LOCAL_TAG=$(git rev-parse --short HEAD)
ssh user@server <<EOF
docker pull myapp:$LOCAL_TAG && docker restart myapp
EOF

# run a block as root without a root subshell hanging around
sudo bash <<'EOF'
systemctl daemon-reload
systemctl enable --now myservice
EOF

# run commands inside a running container (-i keeps stdin open)
docker exec -i mydb bash <<'EOF'
psql -U postgres -c 'VACUUM ANALYZE;'
EOF

# feed a block to any interpreter, not just a shell
python3 <<'EOF'
import sys
print(sys.version)
EOF
```

Gotcha: for `ssh` and `docker exec` you need stdin attached — plain `ssh host` reads the
heredoc fine, but `docker exec` needs `-i`. And a heredoc block runs to completion; it is
not interactive, so commands expecting a TTY (editors, prompts) will misbehave.
