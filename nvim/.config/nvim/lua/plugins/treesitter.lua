return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "typescript", "tsx", "javascript",
      "json", "jsonc", "html", "css",
      "lua", "luadoc", "markdown", "markdown_inline",
      "bash", "yaml", "toml",
      "vim", "vimdoc", "query", "diff",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local lang = vim.treesitter.language.get_lang(filetype)
        if not lang then return end
        if not pcall(vim.treesitter.language.add, lang) then return end
        if not pcall(vim.treesitter.start, buf, lang) then return end
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
