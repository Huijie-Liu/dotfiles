
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
      bigfile      = { enabled = true },
      indent       = { enabled = true },
      input        = { enabled = true },
      notifier     = { enabled = true },
      quickfile    = { enabled = true },
      statuscolumn = { enabled = true },
      words        = { enabled = true },
      scroll       = { enabled = false },

      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
        sources = {
          files = {
            hidden  = true,
            follow  = true,
          },
        },
      },
    },

    keys = {
      {
        "<leader>fa",
        function()
          Snacks.picker.files({ hidden = true, ignored = true })
        end,
        desc = "Find All Files (cwd)",
      },
    },
  },
}

