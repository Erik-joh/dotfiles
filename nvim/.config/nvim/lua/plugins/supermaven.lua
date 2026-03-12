return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion  = "<C-]>",
        accept_word       = "<C-j>",
      },
      ignore_filetypes = { "TelescopePrompt" },
      color = {
        suggestion_color = "#6b7280",
        cterm = 244,
      },
      log_level = "off",
    })
  end,
}
