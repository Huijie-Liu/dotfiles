local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
map("n", "x", '"_x')
map("n", "<Leader>p", '"0p')
map("n", "<Leader>P", '"0P')
map("v", "<Leader>p", '"0p')
map("n", "<Leader>c", '"_c')
map("n", "<Leader>C", '"_C')
map("v", "<Leader>c", '"_c')
map("v", "<Leader>C", '"_C')
map("n", "<Leader>d", '"_d')
map("n", "<Leader>D", '"_D')
map("v", "<Leader>d", '"_d')
map("v", "<Leader>D", '"_D')

-- Basic keymaps
map("n", "<C-q>", "<cmd>close<CR>")
map("n", "<C-[>", "<cmd>e #<CR>")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map("i", "<C-b>", "<Left>", opts)
map("i", "<C-f>", "<Right>", opts)
map("i", "<C-p>", "<Up>", opts)
map("i", "<C-n>", "<Down>", opts)
map("i", "<C-a>", "<Esc>I", opts)
map("i", "<C-e>", "<Esc>A", opts)
map({ "i", "n", "s" }, "<Esc>", function()
  vim.cmd("nohlsearch")
  return "<Esc>"
end, { expr = true, silent = true })

-- Exit insert mode
map("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

-- Move lines
map("n", "<A-down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<Cmd>Oil<CR>", { desc = "Open parent directory" })

-- Disable continuations
map("n", "<Leader>o", "o<Esc>^Da", opts)
map("n", "<Leader>O", "O<Esc>^Da", opts)

-- Resize window
map("n", "<C-w><left>", "<C-w><")
map("n", "<C-w><right>", "<C-w>>")
map("n", "<C-w><up>", "<C-w>+")
map("n", "<C-w><down>", "<C-w>-")

-- Buffer navigation
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Find / pickers
map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fa", function()
  Snacks.picker.files({ hidden = true, ignored = true })
end, { desc = "Find All Files" })
map("n", "<leader>fg", function()
  Snacks.picker.grep()
end, { desc = "Grep" })
map("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Recent Files" })
map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>fc", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })

-- Diagnostics
map("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
map("n", "<leader>sD", function()
  Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev Diagnostic" })

-- Search behavior
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Comment helpers use Neovim's native gc operator
map("n", "gco", "o<Esc>Vcx<Esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<Esc>Vcx<Esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Misc
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map({ "n", "x" }, "<leader>cf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format" })

if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function()
    Snacks.lazygit()
  end, { desc = "Lazygit" })
end
