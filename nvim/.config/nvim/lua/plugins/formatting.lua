return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
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
      -- Format on save (like editor.formatOnSave in vscode)
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    })
  end,
}
