---
date_created: 2026-07-10 17:18
---

# 🚀 Neovim Netrw Mastery Guide
#source #nvim #cheatsheet

Netrw is Neovim’s built-in file explorer. It provides full project management without external plugins.
------------------------------

## 🛠️ Essential Configuration
Add this Lua code to your init.lua to turn Netrw into a clean sidebar tree.

-- Disable the bulky top informational banner
vim.g.netrw_banner = 0
-- Set layout style to an interactive tree view
vim.g.netrw_liststyle = 3
-- Open files in the last active window 
vim.g.netrw_browse_split = 4
-- Restrict sidebar width to 25% of the screen
vim.g.netrw_winsize = 25
-- Toggle the Netrw sidebar explorer with <leader>e
vim.keymap.set('n', '<leader>e', ':Lexplore<CR>', { silent = true })

------------------------------
## 📂 Navigation Shortcuts

| Key | Action |
|---|---|
| Enter | Expand/collapse folder or open file |
| - | Move up one directory level |
| o | Open file in a new horizontal split |
| v | Open file in a new vertical split |
| t | Open file in a new tab |
| p | Open file in a quick preview window |

------------------------------
## 📝 File Operations (CRUD)
Hover over a file or directory and press these keys:

* % → Create a new file
* d → Create a new directory
* R → Rename a file or directory
* D → Delete a file or empty directory

------------------------------
## 🚀 Advanced Tricks## 1. Toggle Sidebar Drawer
Use :Lexplore to open Netrw as a persistent sidebar. Use the custom <leader>e mapping above to quickly toggle it open and closed.
## 2. Bulk Moving and Copying

   1. Press mf on multiple files to mark them.
   2. Navigate to the destination directory.
   3. Press mt to set it as the target.
   4. Press mc to copy (or mm to move) the marked files.

## 3. Sorting Files

* Press s to cycle sorting criteria (name, time, size).
* Press r to reverse the current sorting order.

------------------------------
If you want to expand these notes, let me know:

* Should we add rules to hide folders like node_modules or .git?
* Do you want code to auto-close Netrw when it is the last open buffer?
* Would you like to map H/J/K/L for easier directory jumping?
