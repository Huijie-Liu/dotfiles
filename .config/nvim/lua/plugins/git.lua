return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▔" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      current_line_blame = true,
      on_attach = function(bufnr)
        -- Buffer-local and diff-aware so the built-in ]c/[c motions survive
        -- in diff mode and non-attached buffers (per gitsigns README).
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end, "Next Hunk")
        map("[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end, "Prev Hunk")
      end,
    },
    keys = {
      { "<leader>gh", "<Cmd>Gitsigns preview_hunk<CR>", desc = "Preview Hunk" },
      { "<leader>gb", "<Cmd>Gitsigns blame_line full=true<CR>", desc = "Blame Line" },
      { "<leader>gs", "<Cmd>Gitsigns stage_hunk<CR>", desc = "Stage Hunk" },
      { "<leader>gS", "<Cmd>Gitsigns stage_buffer<CR>", desc = "Stage Buffer" },
      { "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>", desc = "Reset Hunk" },
      { "<leader>gR", "<Cmd>Gitsigns reset_buffer<CR>", desc = "Reset Buffer" },
      { "<leader>ub", "<Cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle Blame" },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
    },
  },
}
