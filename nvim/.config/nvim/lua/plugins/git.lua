return {
  -- Git signs in gutter (like gitlens in vscode)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      -- Git panel (like <leader>gg in vscode → scm view)
      { "<leader>gg", "<cmd>vertical Git<CR>", desc = "Git status" },
      { "<leader>gb", "<cmd>Gitsigns blame_line<CR>", desc = "Blame line" },
      { "]g", "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
      { "[g", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev hunk" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "Unstage hunk" },
    },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "" },
          topdelete    = { text = "" },
          changedelete = { text = "▎" },
          untracked    = { text = "▎" },
        },
        current_line_blame = false,
      })
    end,
  },

  -- Git commands (for <leader>gg → :vertical Git)
  { "tpope/vim-fugitive", cmd = "Git" },
}
