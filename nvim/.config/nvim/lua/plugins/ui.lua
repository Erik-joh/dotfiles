return {
	-- Theme: One Dark Pro (matches VSCode Binaryify/OneDark-Pro Night Flat exactly)
	{
		"olimorris/onedarkpro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Exact colors from Binaryify/OneDark-Pro Night Flat
			local C = {
				bg       = "#16191d",
				fg       = "#abb2bf",
				red      = "#e06c75",  -- variables, parameters, properties
				yellow   = "#e5c07b",  -- types, classes, constructors
				green    = "#98c379",  -- strings
				blue     = "#61afef",  -- functions, methods
				cyan     = "#56b6c2",  -- support functions, built-ins
				purple   = "#c678dd",  -- keywords, storage
				orange   = "#d19a66",  -- numbers, constants
				gray     = "#7f848e",  -- comments
				dimgray  = "#4b5263",  -- line numbers
			}

			require("onedarkpro").setup({
				styles = {
					comments  = "italic",
					keywords  = "italic",
					functions = "italic",
					strings   = "italic",
				},
				options = { italic = true, bold = true },
				-- Baked into the compiled theme cache — always applies
				highlights = {
					["@keyword"]             = { fg = C.purple, italic = true },
					["@keyword.import"]      = { fg = C.purple, italic = true },
					["@keyword.function"]    = { fg = C.purple, italic = true },
					["@keyword.return"]      = { fg = C.purple, italic = true },
					["@keyword.conditional"] = { fg = C.purple, italic = true },
					["@keyword.repeat"]      = { fg = C.purple, italic = true },
					["@keyword.exception"]   = { fg = C.purple, italic = true },
					["@keyword.operator"]    = { fg = C.purple },
					["@keyword.coroutine"]   = { fg = C.purple, italic = true },
					["@variable"]            = { fg = C.red },
					["@variable.builtin"]    = { fg = C.yellow },
					["@variable.parameter"]  = { fg = C.red },
					["@variable.member"]     = { fg = C.red },
					["@function"]            = { fg = C.blue, italic = true },
					["@function.call"]       = { fg = C.blue, italic = true },
					["@function.method"]     = { fg = C.blue, italic = true },
					["@function.method.call"]= { fg = C.blue, italic = true },
					["@function.builtin"]    = { fg = C.cyan, italic = true },
					["@constructor"]         = { fg = C.yellow },
					["@type"]                = { fg = C.yellow },
					["@type.builtin"]        = { fg = C.yellow },
					["@module"]              = { fg = C.yellow },
					["@constant"]            = { fg = C.orange },
					["@constant.builtin"]    = { fg = C.yellow },
					["@string"]              = { fg = C.green, italic = true },
					["@string.special"]      = { fg = C.cyan },
					["@number"]              = { fg = C.orange },
					["@float"]               = { fg = C.orange },
					["@comment"]             = { fg = C.gray, italic = true },
					["@operator"]            = { fg = C.fg },
					["@punctuation.bracket"] = { fg = C.fg },
					["@punctuation.delimiter"]={ fg = C.fg },
					-- LSP semantic tokens baked into theme cache
					["@lsp.type.variable"]      = { fg = C.red },
					["@lsp.type.parameter"]     = { fg = C.red },
					["@lsp.type.property"]      = { fg = C.red },
					["@lsp.type.function"]      = { fg = C.blue, italic = true },
					["@lsp.type.method"]        = { fg = C.blue, italic = true },
					["@lsp.type.type"]          = { fg = C.yellow },
					["@lsp.type.class"]         = { fg = C.yellow },
					["@lsp.type.interface"]     = { fg = C.yellow },
					["@lsp.type.typeParameter"] = { fg = C.yellow },
					["@lsp.type.namespace"]     = { fg = C.yellow },
					["@lsp.type.enum"]          = { fg = C.yellow },
					["@lsp.type.enumMember"]    = { fg = C.yellow },
					["@lsp.type.keyword"]       = { fg = C.purple, italic = true },
					["@lsp.type.string"]        = { fg = C.green, italic = true },
					["@lsp.type.number"]        = { fg = C.orange },
					["@lsp.type.comment"]       = { fg = C.gray, italic = true },
					-- TS LSP modifiers
					["@lsp.typemod.variable.readonly"]          = { fg = C.yellow },
					["@lsp.typemod.variable.local"]             = { fg = C.red },
					["@lsp.typemod.variable.defaultLibrary"]    = { fg = C.yellow },
					["@lsp.typemod.variable.declaration"]       = { fg = C.red },
					["@lsp.typemod.parameter.declaration"]      = { fg = C.red },
					["@lsp.typemod.function.defaultLibrary"]    = { fg = C.cyan, italic = true },
					["@lsp.typemod.function.declaration"]       = { fg = C.blue, italic = true },
					["@lsp.typemod.function.async"]             = { fg = C.blue, italic = true },
					["@lsp.typemod.method.declaration"]         = { fg = C.blue, italic = true },
					["@lsp.typemod.class.defaultLibrary"]       = { fg = C.yellow },
					["@lsp.typemod.class.declaration"]          = { fg = C.yellow },
					["@lsp.typemod.interface.declaration"]      = { fg = C.yellow },
					["@lsp.typemod.type.declaration"]           = { fg = C.yellow },
					["@lsp.typemod.enum.declaration"]           = { fg = C.yellow },
					["@lsp.typemod.typeParameter.declaration"]  = { fg = C.yellow },
				},
			})

			vim.cmd("colorscheme onedark_vivid")

			local hl = vim.api.nvim_set_hl

			local function apply()
				-- Background
				hl(0, "Normal",      { bg = C.bg, fg = C.fg })
				hl(0, "NormalNC",    { bg = C.bg })
				hl(0, "NormalFloat", { bg = C.bg })
				hl(0, "SignColumn",  { bg = C.bg })

				-- Line numbers: dimmed, current line brighter but NO background bar
				hl(0, "LineNr",       { fg = C.dimgray, bg = "NONE" })
				hl(0, "CursorLineNr", { fg = C.fg,      bg = "NONE" })

				-- Cursor line: barely visible, just slightly lighter than bg (#16191d)
				hl(0, "CursorLine", { bg = "#1e2228" })

				-- Word/reference highlights: no background
				hl(0, "LspReferenceText",  { bg = "NONE" })
				hl(0, "LspReferenceRead",  { bg = "NONE" })
				hl(0, "LspReferenceWrite", { bg = "NONE" })

				hl(0, "String",  { fg = C.green, italic = true })
				hl(0, "Comment", { fg = C.gray,  italic = true })

				-- Base colors per LSP token type
				local lsp_types = {
					variable      = { fg = C.red },
					parameter     = { fg = C.red },
					property      = { fg = C.red },
					["function"]  = { fg = C.blue, italic = true },
					method        = { fg = C.blue, italic = true },
					class         = { fg = C.yellow },
					interface     = { fg = C.yellow },
					type          = { fg = C.yellow },
					enum          = { fg = C.yellow },
					enumMember    = { fg = C.yellow },
					typeParameter = { fg = C.yellow },
					namespace     = { fg = C.yellow },
					keyword       = { fg = C.purple, italic = true },
					string        = { fg = C.green, italic = true },
					number        = { fg = C.orange },
					comment       = { fg = C.gray, italic = true },
				}

				-- All known TS LSP modifiers
				local lsp_mods = {
					"declaration", "definition", "readonly", "static",
					"async", "defaultLibrary", "local", "abstract",
					"deprecated", "modification", "documentation",
				}

				-- Set @lsp.type.X and every @lsp.typemod.X.MOD combination
				-- so no modifier combo can override our colors to white
				for type_name, opts in pairs(lsp_types) do
					hl(0, "@lsp.type." .. type_name, opts)
					for _, mod in ipairs(lsp_mods) do
						hl(0, "@lsp.typemod." .. type_name .. "." .. mod, opts)
					end
				end

				-- Specific overrides that differ from base type color
				hl(0, "@lsp.typemod.variable.readonly",       { fg = C.yellow })
				hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = C.yellow })
				hl(0, "@lsp.typemod.function.defaultLibrary", { fg = C.cyan, italic = true })
				hl(0, "@lsp.typemod.class.defaultLibrary",    { fg = C.yellow })
			end

			-- Run after colorscheme, after startup, and after each LSP attach
			vim.schedule(apply)
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function() vim.schedule(apply) end,
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function() vim.schedule(apply) end,
			})
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

	-- Highlight todo/fix/note/etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- File icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },
}
