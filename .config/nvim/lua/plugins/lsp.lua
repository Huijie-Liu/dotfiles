local servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = { globals = { "vim", "Snacks" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
  basedpyright = {},
  ruff = {},
  bashls = {},
  jsonls = {},
  marksman = {},
  taplo = {},
  yamlls = {},
}

for server, config in pairs(servers) do
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  vim.lsp.config(server, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "single" },
  virtual_text = { spacing = 2, source = "if_many" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("MinimalNvimLsp", { clear = true }),
  callback = function(event)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
    end
    map("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
    map("gr", function() Snacks.picker.lsp_references() end, "References")
    map("gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
    map("K", vim.lsp.buf.hover, "Hover")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  end,
})

return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = { ui = { border = "single" } },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = { "lua_ls" },
    },
  },
}
