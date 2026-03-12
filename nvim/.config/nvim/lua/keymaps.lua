local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search highlights on Esc (like VS Code vim Esc → :nohl)
map("n", "<Esc>", "<cmd>nohl<CR>", { silent = true })

-- Scroll with centering (like C-d/C-u zz in vscode vim)
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Split navigation (like ctrl-hjkl in vscode)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Split creation (like sh / sv in vscode)
map("n", "sh", "<cmd>vsplit<CR>")
map("n", "sv", "<cmd>split<CR>")

-- Buffer management (like <leader>bd / <leader>bo in vscode)
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Close other buffers" })

-- Move lines in visual line mode (like Shift-K/J in vscode visual line)
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move lines up" })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move lines down" })

-- Keep selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
