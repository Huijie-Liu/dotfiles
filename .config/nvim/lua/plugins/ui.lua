return {
  {
    "folke/snacks.nvim",
    priority = 900,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
        sources = {
          files = {
            hidden = true,
            follow = true,
          },
        },
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      scroll = { enabled = false },
    },
  },
}
