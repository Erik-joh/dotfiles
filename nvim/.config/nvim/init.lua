-- Leader keys must be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd Font available (JetBrains Mono Nerd Font)
vim.g.have_nerd_font = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" } }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("keymaps")

-- Compatibility shim: new treesitter removed ft_to_lang but telescope still calls it
if vim.treesitter.language.get_lang and not vim.treesitter.language.ft_to_lang then
  vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
end

-- Highlight yanked text (native, no plugin needed)
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

require("lazy").setup("plugins", {
  change_detection = { notify = false },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘", config = "🛠", event = "📅", ft = "📂",
      init = "⚙", keys = "🗝", plugin = "🔌", runtime = "💻",
      require = "🌙", source = "📄", start = "🚀", task = "📌", lazy = "💤 ",
    },
  },
})
