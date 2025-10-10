return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    local flutterConfig = require("flutter-tools")

    flutterConfig.setup({
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = false,
        exception_breakpoints = {},
      },
      root_patterns = { ".git", "pubspec.yaml" },
      fvm = true,
      widget_guides = {
        enabled = false,
      },
      closing_tags = {
        highlight = "Comment",
        prefix = "//",
        enabled = true,
      },
      dev_log = {
        enabled = true,
        notify_errors = false,
        open_cmd = "tabedit",
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        open_cmd = "30vnew",
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = true,
          background = false,
          background_color = nil,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },

        -- THIS IS THE CRITICAL PART FOR FORMAT ON SAVE
        on_attach = function(client, bufnr)
          -- Enable format on save for Dart files
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = vim.api.nvim_create_augroup("DartFormat_" .. bufnr, { clear = true }),
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = false })
            end,
          })
        end,

        capabilities = function(config)
          -- Ensure formatting capabilities are enabled
          config.textDocument = config.textDocument or {}
          config.textDocument.formatting = { dynamicRegistration = true }
          config.textDocument.rangeFormatting = { dynamicRegistration = true }
          return config
        end,

        analysisExcludedFolders = {
          vim.fn.expand("$HOME/.pub-cache"),
          vim.fn.expand("$HOME/fvm"),
          "./fvm/",
        },

        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
          lineLength = 120, -- Set your preferred line length
        },
      },
    })
  end,
}
