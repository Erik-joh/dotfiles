return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    -- Toggle explorer (like <leader>e in vscode)
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, position = "right" })
      end,
      desc = "Toggle file explorer",
    },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        position = "right",
        width = 35,
        mappings = {
          -- Match vscode file explorer keybindings
          ["<CR>"] = "open",
          ["s"]    = "open_vsplit",
          ["S"]    = "open_split",
          ["r"]    = "rename",
          ["a"]    = "add",
          ["A"]    = "add_directory",
          ["d"]    = "delete",
          ["y"]    = "copy_to_clipboard",
          ["x"]    = "cut_to_clipboard",
          ["p"]    = "paste_from_clipboard",
          ["<Esc>"] = "cancel",
        },
      },
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        indent = { padding = 1 },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
        git_status = {
          symbols = {
            added     = "",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },
    })
  end,
}
