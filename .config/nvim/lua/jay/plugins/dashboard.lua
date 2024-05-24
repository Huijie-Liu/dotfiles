return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup({
        -- config
        theme = "hyper",
        config = {
          week_header = {
            enable = true,
          },
          disable_move = true,
          shortcut = {
            {
              icon = "󰊳 ",
              desc = "Update",
              group = "@property",
              action = "Lazy update",
              key = "u",
            },
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Files",
              group = "Label",
              action = "Telescope find_files",
              key = "f",
            },
            {
              icon = " ",
              desc = "Quit",
              action = "exit",
              key = "q",
            },
          },
        },
      })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
}
