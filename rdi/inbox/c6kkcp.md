#fact
2025-12-10 08:07

# Qutebrowser keybindings

Qutebrowser, a keyboard-driven web browser, utilizes Vim-like keybindings for efficient navigation, including tab switching.
** Default Keybindings for Tab Switching:
Next Tab: Press J (Shift + j) to switch to the tab on the right. If you are on the last tab, it will loop around to the first tab.
Previous Tab: Press K (Shift + k) to switch to the tab on the left. If you are on the first tab, it will loop around to the last tab.
Specific Tab: Press <Alt-num> where num is the position of the tab you want to switch to (e.g., Alt-1 for the first tab, Alt-2 for the second, etc.).
Fuzzy Search and Jump: Press gt to open a list of tabs, allowing you to fuzzy search and jump to a specific tab by typing its name or a part of its URL.
Go to Tab at N: Press [N]+Shift+t to jump directly to the tab at position N.
Other Tab-Related Keybindings:
Close Current Tab: Press d.
Close All Tabs but Current: Press co.
Move Current Tab to New Window: Press gD.
Reopen Last Closed Tab: Press Ctrl+Shift+T.
Open a New Tab: Press Ctrl+T.
Customizing Keybindings:
Qutebrowser allows for extensive customization of keybindings. You can modify these bindings using the :bind command within qutebrowser or by editing your config.py file. For instance, to rebind tab-next to the right arrow key, you would use:



