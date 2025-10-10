return {
  "neovim/nvim-lspconfig",
  opts = {
    -- LSP Server configurations
    servers = {

      -- Go Language Server
      gopls = {
        cmd = { "gopls" },
        root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
            hoverKind = "FullDocumentation",
          },
        },
      },

      -- TypeScript/JavaScript Language Server
      vtsls = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      },

      -- Disable deprecated tsserver
      tsserver = {
        enabled = false,
      },
      ts_ls = {
        enabled = false,
      },
    },

    -- This is the critical part that was missing!
    setup = {
      -- Setup handlers for specific servers if needed
      -- Most servers will auto-setup from the servers table above
    },
  },

  -- Add config function to ensure servers are set up
  config = function(_, opts)
    -- Configure diagnostic display
    vim.diagnostic.config({
      virtual_text = true, -- Show errors inline
      signs = true, -- Show signs in gutter
      underline = true, -- Underline errors
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always", -- Show source of diagnostic (e.g., "gopls")
        header = "",
        prefix = "",
      },
    })
    -- Get the lspconfig plugin
    local lspconfig = require("lspconfig")

    -- Setup each server defined in opts.servers
    for server, config in pairs(opts.servers) do
      if config.enabled ~= false then
        lspconfig[server].setup(config)
      end
    end
  end,

  -- Keymaps for TypeScript/JavaScript
  keys = {
    {
      "gD",
      function()
        local params = vim.lsp.util.make_position_params()
        LazyVim.lsp.execute({
          command = "typescript.goToSourceDefinition",
          arguments = { params.textDocument.uri, params.position },
          open = true,
        })
      end,
      desc = "Goto Source Definition",
      ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
    {
      "gR",
      function()
        LazyVim.lsp.execute({
          command = "typescript.findAllFileReferences",
          arguments = { vim.uri_from_bufnr(0) },
          open = true,
        })
      end,
      desc = "File References",
      ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
    {
      "<leader>co",
      LazyVim.lsp.action["source.organizeImports"],
      desc = "Organize Imports",
      ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
    {
      "<leader>cM",
      LazyVim.lsp.action["source.addMissingImports.ts"],
      desc = "Add missing imports",
      ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
    {
      "<leader>cu",
      LazyVim.lsp.action["source.removeUnused.ts"],
      desc = "Remove unused imports",
      ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
    {
      "<leader>cD",
      LazyVim.lsp.action["source.fixAll.ts"],
      desc = "Fix all diagnostics",
      ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
    {
      "<leader>cV",
      function()
        LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
      end,
      desc = "Select TS workspace version",
      ft = { "typescript", "typescriptreact" },
    },
  },
}
