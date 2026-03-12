return {
  -- Surround (like vim-surround in vscode)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Auto close brackets/quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })
      -- Hook into cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Comments (gc to comment, like vscode vim gc)
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Highlight yanked text (like vim.highlightedyank in vscode)
  {
    "machakann/vim-highlightedyank",
    event = "VeryLazy",
    init = function()
      vim.g.highlightedyank_highlight_duration = 200
    end,
  },

  -- Multi-cursor (like Ctrl+N in vscode vim)
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"]         = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
      }
    end,
  },
}
