return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp",
    },
    config = function()
      -- Set up LSP keymaps on every buffer an LSP attaches to
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd",         vim.lsp.buf.definition,    "[G]oto [D]efinition")
          map("gD",         vim.lsp.buf.declaration,   "[G]oto [D]eclaration")
          map("gi",         vim.lsp.buf.implementation,"[G]oto [I]mplementation")
          map("gt",         vim.lsp.buf.type_definition,"[G]oto [T]ype definition")
          map("gr",         vim.lsp.buf.references,    "[G]oto [R]eferences")
          map("K",          vim.lsp.buf.hover,         "Hover Documentation")
          map("gh",         vim.lsp.buf.hover,         "Hover Documentation")
          map("<leader>cr", vim.lsp.buf.rename,        "[C]ode [R]ename")
          map("<leader>ca", vim.lsp.buf.code_action,   "[C]ode [A]ction", { "n", "x" })
          map("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic float")
          map("[d",         vim.diagnostic.goto_prev,  "Prev diagnostic")
          map("]d",         vim.diagnostic.goto_next,  "Next diagnostic")

          -- Highlight references of the word under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/documentHighlight", event.buf) then
            local au = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = au,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = au,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(e)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf })
              end,
            })
          end

          -- Toggle inlay hints
          if client and client:supports_method("textDocument/inlayHint", event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        jump = { float = true },
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      ---@type table<string, vim.lsp.Config>
      local servers = {
        ts_ls  = {},
        eslint = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
      }

      -- Install LSP servers and formatters via Mason
      require("mason-tool-installer").setup({
        ensure_installed = vim.list_extend(vim.tbl_keys(servers), {
          "prettier",
          "stylua",
        }),
      })

      for name, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end
    end,
  },
}
