return {
  -- Theme: One Dark Pro (Night Flat variant)
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        styles = {
          comments = "italic",
          keywords = "italic",
          types = "italic",
        },
        options = {
          bold = true,
          italic = true,
        },
      })
      vim.cmd("colorscheme onedark_dark")
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "onedark",
          globalstatus = true,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- File icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
