local opt = vim.opt

vim.g.snacks_animate = false

opt.autowrite = true
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.linebreak = true
opt.mouse = "a"
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.updatetime = 200
opt.wrap = false

if vim.fn.executable("rg") == 1 then
  opt.grepformat = "%f:%l:%c:%m"
  opt.grepprg = "rg --vimgrep"
end

vim.cmd.colorscheme("habamax")

vim.g.markdown_recommended_style = 0
