local opt = vim.opt

opt.autowrite = true
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true })
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.winborder = "single"
opt.wrap = false

-- no snacks animations (indent scope, etc.)
vim.g.snacks_animate = false

vim.g.markdown_recommended_style = 0
