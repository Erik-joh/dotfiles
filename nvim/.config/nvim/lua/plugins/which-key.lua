return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    spec = {
      { "<leader>s", group = "[S]earch" },
      { "<leader>c", group = "[C]ode" },
      { "<leader>g", group = "[G]it" },
      { "<leader>h", group = "[H]arpoon" },
      { "<leader>b", group = "[B]uffer" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>9", group = "[9]9 AI" },
    },
  },
}
