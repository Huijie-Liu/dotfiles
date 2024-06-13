return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Enable transparent background
        transparent = true,
        -- Enable italics comments
        italic_comments = true,
        -- Replace all fillchars with ' ' for the ultimate clean look
        hide_fillchars = true,
      })
      vim.cmd("colorscheme cyberdream")
    end,
  },
}
