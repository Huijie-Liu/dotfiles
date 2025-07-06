local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Basic keymaps
keymap.set("n", "<C-q>", "<cmd>close<CR>")
keymap.set("n", "<C-[>", "<cmd>e #<CR>")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-f>", "<C-f>zz")
keymap.set("n", "<C-b>", "<C-b>zz")
keymap.set("i", "<C-b>", "<Left>", opts)
keymap.set("i", "<C-f>", "<Right>", opts)
keymap.set("i", "<C-p>", "<Up>", opts)
keymap.set("i", "<C-n>", "<Down>", opts)
keymap.set("i", "<C-a>", "<Esc>I", opts)
keymap.set("i", "<C-e>", "<Esc>A", opts)

-- Exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Move Lines
keymap.set("n", "<A-down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
keymap.set("n", "<A-up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
keymap.set("i", "<A-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap.set("i", "<A-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<A-down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Oil file manager
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
