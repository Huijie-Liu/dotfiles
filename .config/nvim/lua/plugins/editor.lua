return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				json = { "jq" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				fish = { "fish_indent" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		---@module "oil"
		---@type oil.SetupOpts
		opts = {
			default_file_explorer = true,
			keymaps = {
				["q"] = { "actions.close", mode = "n" },
			},
		},
	},
	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		opts = {
			n_lines = 500,
			custom_textobjects = {
				g = function()
					local from = { line = 1, col = 1 }
					local last_line = vim.fn.line("$")
					local to = {
						line = last_line,
						col = math.max(vim.fn.getline(last_line):len(), 1),
					}
					return { from = from, to = to }
				end,
			},
		},
	},
	{
		"nvim-mini/mini.surround",
		event = "VeryLazy",
		opts = {},
	},
}
