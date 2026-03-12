return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "typescript", "tsx", "javascript",
        "json", "jsonc", "html", "css",
        "lua", "markdown", "markdown_inline",
        "bash", "yaml", "toml",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
