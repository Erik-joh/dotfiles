return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		picker = {
			enabled = true,
			sources = {
			files = {
				hidden = true,
				ignored = false,
				exclude = { "node_modules", ".git", "dist", ".dist" },
			},
			grep = {
				hidden = true,
				ignored = false,
				exclude = { "node_modules", ".git", "dist", ".dist" },
			},
			},
			layout = {
				layout = {
					box = "horizontal",
					backdrop = false,
					width = 0.95,
					height = 0.9,
					border = "none",
					{
						box = "vertical",
						{
							win = "input",
							height = 1,
							border = true,
							title = "{title} {live} {flags}",
							title_pos = "center",
						},
						{ win = "list", title = " Results ", title_pos = "center", border = true },
					},
					{
						win = "preview",
						title = "{preview:Preview}",
						width = 0.5,
						border = true,
						title_pos = "center",
					},
				},
			},
		},
		gitbrowse = {},
		image = { enabled = true },
		indent = { enabled = false },
		lazygit = {
			win = { width = 0, height = 0 },
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
	},
	keys = {
		-- File/search keymaps (matching previous telescope bindings)
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "[S]earch [F]iles",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "[S]earch by [G]rep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "[S]earch current [W]ord",
			mode = { "n", "x" },
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.recent()
			end,
			desc = "[S]earch [R]ecent files",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[S]earch [H]elp",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "[S]earch [K]eymaps",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[S]earch [D]iagnostics",
		},
		{
			"<leader>s.",
			function()
				Snacks.picker.resume()
			end,
			desc = "[S]earch Resume",
		},
		{
			"<leader>sn",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "[S]earch [N]eovim files",
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[ ] Find existing buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
			desc = "[/] Fuzzily search in current buffer",
		},

		-- LSP keymaps via picker
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "LSP: [G]oto [D]efinition",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "LSP: [G]oto [R]eferences",
		},
		{
			"gi",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "LSP: [G]oto [I]mplementation",
		},
		{
			"gt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "LSP: [G]oto [T]ype definition",
		},
		{
			"<leader>cs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "[C]ode [S]ymbols (document)",
		},
		{
			"<leader>cS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "[C]ode [S]ymbols (workspace)",
		},

		-- Git browse
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},

		-- Lazygit
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},

		-- Notifier
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
	},
}
