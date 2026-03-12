local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split" -- Live preview of substitutions

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.wrap = false
opt.splitright = true
opt.splitbelow = true
opt.showmode = false
opt.pumheight = 10
opt.confirm = true -- Ask to save instead of erroring on :q
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " " } -- hide ~ on empty lines

-- Clipboard (scheduled to avoid startup slowdown)
vim.schedule(function() opt.clipboard = "unnamedplus" end)

-- Files
opt.backup = false
opt.swapfile = false
opt.undofile = true

-- Perf / misc
opt.updatetime = 250
opt.timeoutlen = 300
opt.mouse = "a"
