if not vim.g.vscode then return {} end

local vscode = require("vscode")
local keymap = vim.keymap

-- File operations
keymap.set("n", "<leader><leader>", function() vscode.action("workbench.action.quickOpen") end, { desc = "Quick Open" })
keymap.set("n", "<leader>e", function() vscode.action("revealInExplorer") end, { desc = "Reveal in Explorer" })
keymap.set("n", "<leader>r", function() vscode.action("editor.action.rename") end, { desc = "Rename Symbol" })

-- Debug and terminal
keymap.set("n", "<leader>b", function() vscode.action("editor.debug.action.toggleBreakpoint") end, { desc = "Toggle Breakpoint" })
keymap.set("n", "<leader>t", function() vscode.action("workbench.action.terminal.toggleTerminal") end, { desc = "Toggle Terminal" })

-- Split management
keymap.set("n", "<leader>v", function() vscode.action("workbench.action.splitEditorRight") end, { desc = "Split Right" })
keymap.set("n", "<leader>s", function() vscode.action("workbench.action.splitEditorDown") end, { desc = "Split Down" })
keymap.set("n", "<leader>|", function() vscode.action("workbench.action.splitEditorRight") end, { desc = "Split Right" })
keymap.set("n", "<leader>-", function() vscode.action("workbench.action.splitEditorDown") end, { desc = "Split Down" })
