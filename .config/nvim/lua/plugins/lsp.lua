local uv = vim.uv or vim.loop

local function existing_paths(paths)
  local seen = {}
  local ret = {}

  for _, path in ipairs(paths) do
    if type(path) == "string" and path ~= "" and not seen[path] and uv.fs_stat(path) then
      seen[path] = true
      ret[#ret + 1] = path
    end
  end

  return ret
end

local function lua_library()
  local paths = {
    vim.env.VIMRUNTIME,
    vim.fn.stdpath("config"),
  }

  vim.list_extend(paths, vim.api.nvim_list_runtime_paths())
  vim.list_extend(paths, vim.fn.glob(vim.fn.stdpath("data") .. "/lazy/*", true, true))

  return existing_paths(paths)
end

local ensure_installed = {
  "lua_ls",
  "ruff",
}

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = { "vim", "Snacks" },
        },
        workspace = {
          checkThirdParty = false,
          library = lua_library(),
        },
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

local function configure(server, config)
  config = config or {}
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  vim.lsp.config(server, config)
end

return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = {
      ui = {
        border = "single",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_enable = false,
      })

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

      for server, config in pairs(servers) do
        configure(server, config)
        vim.lsp.enable(server)
      end
    end,
  },
}
