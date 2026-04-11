local function executable(cmd)
  return vim.fn.executable(cmd) == 1
end

local function configure(server, cmd, config)
  if cmd and not executable(cmd) then
    return
  end

  config = config or {}
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
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

          map("gd", function()
            Snacks.picker.lsp_definitions()
          end, "Goto Definition")
          map("gr", function()
            Snacks.picker.lsp_references()
          end, "References")
          map("gI", function()
            Snacks.picker.lsp_implementations()
          end, "Goto Implementation")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        end,
      })

      configure("lua_ls", "lua-language-server", {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })

      if executable("basedpyright-langserver") then
        configure("basedpyright")
      elseif executable("pyright-langserver") then
        configure("pyright")
      end

      configure("ruff", "ruff")
      configure("bashls", "bash-language-server")
      configure("jsonls", "vscode-json-language-server")
      configure("marksman", "marksman")
      configure("taplo", "taplo")
      configure("yamlls", "yaml-language-server")
    end,
  },
}
