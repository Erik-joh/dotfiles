return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "eslint", "lua_ls" },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(keys, cmd, desc)
          vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
        end

        -- Go to (like <leader>gd/gr/gi in vscode)
        map("<leader>gd", vim.lsp.buf.definition,      "Go to definition")
        map("<leader>gr", "<cmd>Telescope lsp_references<CR>", "Go to references")
        map("<leader>gi", vim.lsp.buf.implementation,  "Go to implementation")
        map("<leader>gt", vim.lsp.buf.type_definition, "Go to type definition")

        -- Code actions (like <leader>ca / <leader>cr in vscode)
        map("<leader>ca", vim.lsp.buf.code_action,     "Code action")
        map("<leader>cr", vim.lsp.buf.rename,          "Rename")

        -- Hover (like Shift-K in vscode)
        map("K", vim.lsp.buf.hover, "Hover")

        -- Diagnostics
        map("<leader>cd", vim.diagnostic.open_float,   "Diagnostic float")
        map("[d", vim.diagnostic.goto_prev,            "Prev diagnostic")
        map("]d", vim.diagnostic.goto_next,            "Next diagnostic")
      end

      lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.eslint.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })

      -- Diagnostic signs
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })
    end,
  },
}
