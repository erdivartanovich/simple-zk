#source
2025-12-11 20:09

# Testing luafile

```bash
$ cd /home/rdi/.config && lua -e "
loadfile('nvim/lua/modules/auto/cmd-status.lua')
print('Testing format_tab_name_fixed_width function:')
print('Short name:', format_tab_name_fixed_width('init.lua', 20))
print('Exact length:', format_tab_name_fixed_width('exactly-20-chars.txt', 20))
print('Long name:', format_tab_name_fixed_width('very-long-filename-with-many-parts.lua', 20))
"
```
