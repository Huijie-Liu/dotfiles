return {
  {
    "saghen/blink.cmp",
    version = "*", -- stable tag: required for the prebuilt fuzzy binary (downloads fail on main)
    lazy = false,
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-e>"] = { "hide", "fallback" },
      },
      completion = {
        menu = { border = "single" },
        documentation = {
          window = { border = "single" },
        },
        list = {
          selection = { auto_insert = false },
        },
        trigger = { show_in_snippet = false },
      },
      signature = {
        enabled = true,
        window = { border = "single" },
      },
      -- no snippets provider: this config ships no snippet collection
      sources = {
        default = { "lsp", "path", "buffer" },
      },
    },
  },
}
