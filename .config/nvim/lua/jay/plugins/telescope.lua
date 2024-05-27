return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.providers.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            height = 0.9,
            preview_cutoff = 120,
            prompt_position = "bottom",
            width = 0.8
          }
        },
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Fuzzy find git files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Lists Jump List entries" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fC", "<cmd>Telescope colorscheme<cr>", { desc = "Change colorscheme" })
    keymap.set("n", "<leader>fx", "<cmd>Telescope commands<cr>", { desc = "Exec commands" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Check all keymaps" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope command_history<cr>", { desc = "Command history" })
    keymap.set("n", "<leader>fH", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
  end,
}
