return {
  -- noice: messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  -- nvim notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- lualine status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "┊", right = "┊" },
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },

          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return LazyVim.ui.fg("Statement") end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return LazyVim.ui.fg("Constant") end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return LazyVim.ui.fg("Debug") end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return LazyVim.ui.fg("Special") end,
          },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "neo-tree", "lazy" },
      }

      -- do not add trouble symbols if aerial is enabled
      if vim.g.trouble_lualine then
        local trouble = require("trouble")
        local symbols = trouble.statusline
          and trouble.statusline({
            mode = "symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            hl_group = "lualine_c_normal",
          })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = symbols and symbols.has,
        })
      end

      return opts
    end,
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- zen mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣶⣶⡶⣶⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣲⣿⡿⠋⣹⣾⣿⣿⣿⠟⣻⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢦⣾⣿⣿⠻⠷⣿⣿⡿⢏⠠⣿⣿⣿⣿⣶⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣼⣿⣿⣏⣿⠿⠿⠿⣅⣬⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣿⣿⣿⣿⡄⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣽⣿⣿⣿⣿⡄⣠⠤⢴⣗⠹⢿⡍⡀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡿⣷⢮⠩⠊⠻⠿⡇⠀⠈⠁⣀⣶⣦⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠡⢤⡴⠀⠁⠀⠀⠁⠀⠀⠐⠉⢿⣿⡄⠑⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣐⡀⠀⠀⠀⠀⢀⠔⠁⠀⠀⢹⠀⠀⠈⠐⡤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣾⣿⣿⣦⣀⣠⣾⠁⠀⠀⠀⠀⢨⠀⠀⠀⠀⡇⠀⠉⠒⠦⡀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⡿⣿⣿⣿⣷⠀⠀⢀⢤⡇⠀⠀⠀⠀⡏⠘⠂⢀⠀⠠⡙⣄⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⣻⡿⠏⠀⠀⢀⣿⣿⣿⣿⣿⣾⣾⣿⠀⠀⠀⠀⠀⡇⠀⠀⠀⠈⢒⢔⣼⣷⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⢻⣿⣿⡷⠖⠁⢿⣿⣿⣿⣿⣿⡿⣷⠀⠀⠀⠀⠀⡇⢀⠄⠀⣀⠔⠑⠉⢻⡇⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣞⠝⢧⡈⢿⣧⠀⠀⠀⢸⣿⣿⣿⣾⣶⣿⡟⢴⣶⣶⣤⣤⡇⡎⢀⡴⠁⠀⠀⢀⣿⣿⡀⠀⠀
    ⠠⠄⣤⠀⣀⠀⠀⠀⠀⠀⠀⠀⢠⣼⣷⡤⢝⡢⠷⣼⣿⡆⠀⠀⢸⣿⣿⣿⣿⣿⣿⠗⠀⠹⣿⠏⠉⣸⠃⣿⢁⠼⣍⣡⢬⣥⣾⣧⠀⠀
    ⠀⠀⠀⠀⠀⠉⠑⠒⠰⠂⠄⢠⣿⣭⠭⣍⣑⢙⣷⣾⣿⣿⠀⠀⢸⣿⣿⣿⣿⣿⣿⠀⠀⢦⡿⢀⣠⡿⠖⣿⣂⠜⣿⣗⠶⠿⠿⣿⡀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠉⠙⢿⣿⣿⡇⠀⣼⣿⣿⣿⣿⣿⣿⠀⢀⣿⢋⣀⣿⠁⠀⣿⠇⠀⢿⣟⣀⣀⣬⣿⣷⠀
    ⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⢶⡄⠀⢽⣿⣷⠻⣿⣿⣿⣿⣿⣿⣿⠠⣾⣿⣶⣴⣿⣾⣿⣿⡔⣒⣚⣛⡛⠛⠛⣩⣿⡄
    ⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⢻⣿⡄⣼⣿⡿⢾⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⡿⠿⠟⠛⠛⠻⢖⠲⢔⢾⣭⣓⠦⣽⣿⡇
    ⠘⣿⣿⣶⣦⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣿⡿⠛⠉⠀⠀⠈⠉⠛⠛⢿⢏⣩⣟⢿⠥⣶⣦⡀⠀⠀⠀⠀⠈⠳⣤⡈⠻⣷⣜⣿⡟
    ⠀⢹⣿⣿⣿⣿⣿⣷⣦⣴⣶⣤⣀⡀⡀⠀⠀⣉⢀⠀⡠⠂⠀⠀⡀⠀⠀⠀⢠⣾⣿⣂⣴⡺⢿⣿⣿⣄⠀⠀⢀⠀⠀⣯⣏⣷⣦⣽⣾⠁
    ⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡆⡰⣁⣴⠟⢈⣡⣤⣀⣀⣻⣿⣽⣿⣿⣿⣭⣿⣿⣿⣆⠀⠈⠀⠀⣿⣿⣿⣿⣿⠃⠀
    ⠀⠒⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣿⢧⣿⣧⣶⣿⣿⠭⠍⠉⣹⡦⢤⣀⠀⠠⢤⣾⣿⡿⢋⣠⣴⣷⣾⠿⠿⠿⠟⠛⠒⠠
    ⠀⠀⠀⠀⠀⠀⠉⠙⠛⠛⠿⢿⣿⣿⣿⣿⣿⣿⡼⠿⢛⢏⣻⣭⠴⠶⡚⣋⣹⡇⡇⠚⠙⠂⣼⣿⠀⠈⠉⢉⣁⣠⣠⣤⣀⣄⡀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠛⠛⠓⠒⠒⠉⠁⠠⠦⠿⠛⠋⠉⡷⠻⠟⠒⠭⠿⡋⠀⢠⣼⣞⣿⣿⡿⣿⣿⠽⠃⠀⠀⠀
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
