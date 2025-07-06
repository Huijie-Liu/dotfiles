-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load VSCode specific configuration
if vim.g.vscode then require("config.vscode") end
