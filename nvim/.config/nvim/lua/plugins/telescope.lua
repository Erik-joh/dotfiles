return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    -- Files (like Shift+Cmd+F in vscode)
    { "<leader>ff", "<cmd>Telescope find_files<CR>",              desc = "Find files" },
    -- Text search (like Shift+Cmd+S in vscode)
    { "<leader>fg", "<cmd>Telescope live_grep<CR>",               desc = "Live grep" },
    -- Buffers (like <leader>, in vscode)
    { "<leader>,",  "<cmd>Telescope buffers<CR>",                 desc = "Buffers" },
    -- Document symbols (like <leader>cs in vscode)
    { "<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>",    desc = "Document symbols" },
    -- Workspace symbols
    { "<leader>cS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace symbols" },
    -- Grep word under cursor
    { "<leader>fw", "<cmd>Telescope grep_string<CR>",             desc = "Grep word under cursor" },
    -- Recent files
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>",                desc = "Recent files" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

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
        file_ignore_patterns = { "node_modules", ".git/" },
      },
    })

    telescope.load_extension("fzf")
  end,
}
