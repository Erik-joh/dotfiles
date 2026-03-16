return {
	-- Theme: One Dark Pro (Night Flat colors)
	{
		"olimorris/onedarkpro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedarkpro").setup({
				styles = {
					comments = "italic",
					keywords = "italic",
					functions = "italic",
					strings = "italic",
				},
				options = { italic = true, bold = true },
			})
			vim.cmd("colorscheme onedark_vivid")

			local C = {
				-- bg = "#070e17",
				bg = "#0d1621",
				fg = "#abb2bf",
				red = "#e06c75",
				yellow = "#e5c07b",
				green = "#98c379",
				blue = "#61afef",
				cyan = "#56b6c2",
				purple = "#c678dd",
				orange = "#d19a66",
				gray = "#7f848e",
				dimgray = "#4b5263",
			}

			local function apply()
				local hl = vim.api.nvim_set_hl

				-- Background / chrome
				hl(0, "Normal", { bg = C.bg, fg = C.fg })
				hl(0, "NormalNC", { bg = C.bg })
				hl(0, "NormalFloat", { bg = C.bg })
				hl(0, "SignColumn", { bg = C.bg })
				hl(0, "LineNr", { fg = C.dimgray, bg = "NONE" })
				hl(0, "CursorLineNr", { fg = C.fg, bg = "NONE" })
				hl(0, "CursorLine", { bg = "#1e2228" })

				-- Reference highlights: no background
				hl(0, "LspReferenceText", { bg = "NONE" })
				hl(0, "LspReferenceRead", { bg = "NONE" })
				hl(0, "LspReferenceWrite", { bg = "NONE" })

				-- Core syntax (treesitter)
				hl(0, "Comment", { fg = C.gray, italic = true })
				hl(0, "String", { fg = C.green, italic = true })
				hl(0, "@comment", { fg = C.gray, italic = true })
				hl(0, "@string", { fg = C.green, italic = true })

				hl(0, "@keyword", { fg = C.purple, italic = true })
				hl(0, "@keyword.import", { fg = C.purple, italic = true })
				hl(0, "@keyword.function", { fg = C.purple, italic = true })
				hl(0, "@keyword.return", { fg = C.purple, italic = true })
				hl(0, "@keyword.conditional", { fg = C.purple, italic = true })
				hl(0, "@keyword.repeat", { fg = C.purple, italic = true })
				hl(0, "@keyword.exception", { fg = C.purple, italic = true })
				hl(0, "@keyword.operator", { fg = C.purple })
				hl(0, "@keyword.coroutine", { fg = C.purple, italic = true })

				hl(0, "@variable", { fg = C.red })
				hl(0, "@variable.builtin", { fg = C.yellow })
				hl(0, "@variable.parameter", { fg = C.red })
				hl(0, "@variable.member", { fg = C.red })

				hl(0, "@function", { fg = C.blue, italic = true })
				hl(0, "@function.call", { fg = C.blue, italic = true })
				hl(0, "@function.method", { fg = C.blue, italic = true })
				hl(0, "@function.method.call", { fg = C.blue, italic = true })
				hl(0, "@function.builtin", { fg = C.cyan, italic = true })

				hl(0, "@constructor", { fg = C.yellow })
				hl(0, "@type", { fg = C.yellow })
				hl(0, "@type.builtin", { fg = C.yellow })
				hl(0, "@module", { fg = C.yellow })
				hl(0, "@constant", { fg = C.orange })
				hl(0, "@number", { fg = C.orange })
				hl(0, "@float", { fg = C.orange })
				hl(0, "@operator", { fg = C.fg })

				-- LSP semantic tokens: set base type colors
				local types = {
					variable = C.red,
					parameter = C.red,
					property = C.red,
					["function"] = C.blue,
					method = C.blue,
					class = C.yellow,
					interface = C.yellow,
					type = C.yellow,
					enum = C.yellow,
					enumMember = C.yellow,
					typeParameter = C.yellow,
					namespace = C.yellow,
					keyword = C.purple,
					string = C.green,
					number = C.orange,
					comment = C.gray,
				}

				local mods = {
					"declaration",
					"definition",
					"readonly",
					"static",
					"async",
					"defaultLibrary",
					"local",
					"abstract",
					"deprecated",
					"modification",
					"documentation",
				}

				-- Set every @lsp.type.X and @lsp.typemod.X.MOD
				for t, color in pairs(types) do
					local italic = (
						t == "function"
						or t == "method"
						or t == "keyword"
						or t == "string"
						or t == "comment"
					)
					hl(0, "@lsp.type." .. t, { fg = color, italic = italic })
					for _, m in ipairs(mods) do
						hl(0, "@lsp.typemod." .. t .. "." .. m, { fg = color, italic = italic })
					end
				end

				-- Specific overrides that differ from base type
				hl(0, "@lsp.typemod.variable.readonly", { fg = C.yellow })
				hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = C.yellow })
				hl(0, "@lsp.typemod.function.defaultLibrary", { fg = C.cyan, italic = true })

				-- Snacks picker: match editor background
				hl(0, "SnacksPickerList", { bg = C.bg })
				hl(0, "SnacksPickerPreview", { bg = C.bg })
				hl(0, "SnacksPickerInput", { bg = C.bg })
				hl(0, "SnacksPickerInputBorder", { bg = C.bg, fg = "#c8ccd4" })
				hl(0, "SnacksPickerListBorder", { bg = C.bg, fg = "#c8ccd4" })
				hl(0, "SnacksPickerPreviewBorder", { bg = C.bg, fg = "#c8ccd4" })
				hl(0, "SnacksPickerInputTitle", { bg = C.bg, fg = C.blue })
				hl(0, "SnacksPickerListTitle", { bg = C.bg, fg = C.blue })
				hl(0, "SnacksPickerPreviewTitle", { bg = C.bg, fg = C.blue })
			end

			apply()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = apply,
			})
			-- Re-apply 200ms after LSP attaches (waits for semantic token render)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function()
					vim.defer_fn(apply, 200)
				end,
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

	-- Floating cmdline + message UI
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
			},
			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
			},
			-- Disable LSP features (fidget.nvim handles progress, blink.cmp handles signature)
			lsp = {
				progress = { enabled = false },
				hover = { enabled = false },
				signature = { enabled = false },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			-- Use snacks.notifier instead of nvim-notify
			notify = { enabled = false },
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		},
	},

	-- File icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },
}
