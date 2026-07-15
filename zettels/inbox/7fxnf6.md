#source
2025-12-26 14:32

# Vim - Execute current line as external command

And replace the line with the result.

Example:

```bash
date +%F\ %T
```

Type the command above in the editor buffer directly and then from normal mode press:
`!!sh`

**Benefit**:

- No need to deal with escape character.

When execute from Ex Command, we must excape it like this:

```vim
date +\%F\ \%T
```
