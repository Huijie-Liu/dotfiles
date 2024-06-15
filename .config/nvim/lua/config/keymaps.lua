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

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
-- keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<Leader>cj", function()
  vim.diagnostic.goto_next()
end, { desc = "Jump to next diagnostic issue" }, opts)

keymap.set("n", "<leader>r", function()
  require("jay.hsl").replaceHexWithHSL()
end, { desc = "Replace hex color with HSL" })

keymap.set("n", "<leader>i", function()
  require("jay.lsp").toggleInlayHints()
end, { desc = "Toggle LSP inlay hints" })
