return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<Esc>"] = actions.close,
          },
        },
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        file_ignore_patterns = { "node_modules", ".git/", ".dist" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
          "--glob=!.dist/",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    })

    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    -- File/search keymaps
    vim.keymap.set("n", "<leader>sf", builtin.find_files,    { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep,     { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string,   { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sr", builtin.oldfiles,      { desc = "[S]earch [R]ecent files" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags,     { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps,       { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics,   { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>s.", builtin.resume,        { desc = "[S]earch Resume" })
    vim.keymap.set("n", "<leader>sn", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "[S]earch [N]eovim files" })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    -- Fuzzy search in current buffer
    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- LSP keymaps via telescope (override basic vim.lsp.buf ones for picker UI)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
      callback = function(event)
        local buf = event.buf
        vim.keymap.set("n", "gd",  builtin.lsp_definitions,               { buffer = buf, desc = "LSP: [G]oto [D]efinition" })
        vim.keymap.set("n", "gr",  builtin.lsp_references,                { buffer = buf, desc = "LSP: [G]oto [R]eferences" })
        vim.keymap.set("n", "gi",  builtin.lsp_implementations,           { buffer = buf, desc = "LSP: [G]oto [I]mplementation" })
        vim.keymap.set("n", "gt",  builtin.lsp_type_definitions,          { buffer = buf, desc = "LSP: [G]oto [T]ype definition" })
        vim.keymap.set("n", "<leader>cs", builtin.lsp_document_symbols,   { buffer = buf, desc = "[C]ode [S]ymbols (document)" })
        vim.keymap.set("n", "<leader>cS", builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = "[C]ode [S]ymbols (workspace)" })
      end,
    })
  end,
}
