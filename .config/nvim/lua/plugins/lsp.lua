local servers = {
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = { globals = { "vim", "Snacks" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
  basedpyright = {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  },
  ruff = {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "ruff.toml", ".ruff.toml", "pyproject.toml", ".git" },
  },
  bashls = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash", "zsh" },
    root_markers = { ".git" },
  },
  jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
  },
  marksman = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
    root_markers = { ".git" },
  },
  taplo = {
    cmd = { "taplo", "lsp", "stdio" },
    filetypes = { "toml" },
    root_markers = { "taplo.toml", ".git" },
  },
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    root_markers = { ".git" },
  },
}

-- Enable servers on User LazyDone (after lazy.setup), so blink.cmp (lazy =
-- false) and mason are loaded first — required on a fresh clone, and still
-- ahead of the first FileType event so the initial buffer attaches.
local function setup()
  local capabilities = require("blink.cmp").get_lsp_capabilities()
  for server, config in pairs(servers) do
    config.capabilities = capabilities
    vim.lsp.config(server, config)
  end
  vim.lsp.enable(vim.tbl_keys(servers))
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = setup,
})

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "single" },
  virtual_text = { spacing = 2, source = "if_many" },
})

-- LSP progress → one in-place notification (see `:h LspProgress`)
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value
    if type(value) ~= "table" then
      return
    end
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local msg = value.message ~= "" and value.message or value.title or value.kind
    vim.notify(msg, "info", {
      id = "lsp_progress",
      title = client and client.name or "LSP",
      icon = value.kind == "end" and "" or "󰥔",
    })
  end,
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
    map("gD", function()
      Snacks.picker.lsp_type_definitions()
    end, "Goto Type Definition")
    map("gr", function()
      Snacks.picker.lsp_references()
    end, "References")
    map("gI", function()
      Snacks.picker.lsp_implementations()
    end, "Goto Implementation")
    map("K", vim.lsp.buf.hover, "Hover")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end
  end,
})

return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = { ui = { border = "single" } },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        -- LSP servers (mason package names)
        "lua-language-server",
        "basedpyright",
        "ruff",
        "bash-language-server",
        "json-lsp",
        "marksman",
        "taplo",
        "yaml-language-server",
        -- formatters (conform)
        "stylua",
        "prettier",
      },
      debounce_hours = 24, -- don't verify all packages on every start
    },
  },
}
