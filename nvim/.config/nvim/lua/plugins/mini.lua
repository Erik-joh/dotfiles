return {
  "nvim-mini/mini.nvim",
  config = function()
    -- Better around/inside text objects
    -- Examples: va) ci' yinq
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings
    -- Examples: saiw) sd' sr)'
    require("mini.surround").setup()

    -- Comment lines/blocks with gc
    require("mini.comment").setup()
  end,
}
