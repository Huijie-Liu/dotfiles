return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("dracula")
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 900,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			picker = {
				enabled = true,
				win = {
					input = {
						keys = {
							["<Esc>"] = { "close", mode = { "n", "i" } },
						},
					},
				},
				sources = {
					files = {
						hidden = true,
						follow = true,
					},
				},
			},
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			scroll = { enabled = false },
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			triggers = {
				{ "<auto>", mode = "nixsotc" },
				{ "s", mode = { "n", "x" } },
			},
			win = {
				no_overlap = false,
				width = { min = 28, max = 38 },
				height = { min = 4, max = 12 },
				col = math.huge,
				row = math.huge,
				border = "single",
				padding = { 0, 1 },
				title = false,
			},
			spec = {
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "code" },
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{ "<leader>q", group = "quit" },
				{ "<leader>s", group = "search" },
			},
		},
	},
}
