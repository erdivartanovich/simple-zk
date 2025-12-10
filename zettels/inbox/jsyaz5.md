#literature
2025-12-09 10:18

# Completion in Nvim

Popular completion plugin in neovim that I prefer to use lately are:
- nvim cmp
- blink cmp 

Some plugins may come with specific configuration or setup that require one of those cmp plugin. So beware when you switching from one completion to the other. In my experience I was switching from nvim-cmp to blink, when some other plugins still bind to it. So when I try to uninstall nvim-cmp, it will always automatically reinstalled again because other plugin still depend on it.
This is default behaviour of the `Lazy.nvim` plugin manager that I use.
