return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")
    return {
      -- Add current file (like Shift+Cmd+M in vscode)
      { "<leader>ha", function() harpoon:list():add() end,     desc = "Harpoon add file" },
      -- Open harpoon menu (like Shift+Cmd+H in vscode)
      { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon menu" },
      -- Remove current file (like Shift+Cmd+D in vscode)
      { "<leader>hd", function() harpoon:list():remove() end,  desc = "Harpoon remove file" },
      -- Jump to files 1–4 (like Shift+Cmd+J/K/L/; in vscode)
      { "<leader>1",  function() harpoon:list():select(1) end, desc = "Harpoon file 1" },
      { "<leader>2",  function() harpoon:list():select(2) end, desc = "Harpoon file 2" },
      { "<leader>3",  function() harpoon:list():select(3) end, desc = "Harpoon file 3" },
      { "<leader>4",  function() harpoon:list():select(4) end, desc = "Harpoon file 4" },
    }
  end,
  config = function()
    require("harpoon"):setup()
  end,
}
