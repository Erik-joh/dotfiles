local map = vim.keymap.set

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohl<CR>", { silent = true })

-- Diagnostic quickfix list
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Scroll with centering
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Split navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

-- Split creation
map("n", "sh", "<cmd>vsplit<CR>")
map("n", "sv", "<cmd>split<CR>")

-- Buffer management
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Close other buffers" })

-- Move lines in visual mode
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move lines up" })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move lines down" })

-- Keep selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
