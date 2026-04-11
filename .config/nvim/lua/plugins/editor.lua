local show_oil_details = false

return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      columns = {},
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            show_oil_details = not show_oil_details
            if show_oil_details then
              require("oil").set_columns({ "permissions", "size", "mtime" })
            else
              require("oil").set_columns({})
            end
          end,
        },
      },
      view_options = {
        show_hidden = true,
      },
    },
  },
}
