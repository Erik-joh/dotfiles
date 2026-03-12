return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "[C]ode [F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 2000,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua             = { "stylua" },
      javascript      = { "prettier" },
      javascriptreact = { "prettier" },
      typescript      = { "prettier" },
      typescriptreact = { "prettier" },
      json            = { "prettier" },
      jsonc           = { "prettier" },
      html            = { "prettier" },
      css             = { "prettier" },
      markdown        = { "prettier" },
      yaml            = { "prettier" },
    },
  },
}
