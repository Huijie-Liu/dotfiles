return {
  -- cyberdream theme
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    config = function()
      require("cyberdream").setup({
        -- Enable transparent background
        transparent = true,
        -- Enable italics comments
        italic_comments = true,
        -- Replace all fillchars with ' ' for the ultimate clean look
        hide_fillchars = true,
      })
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
}
