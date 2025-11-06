return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = {
            winblend = 0,
            border = 'none',
          },
        },
      },
    },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    -- Diagnostic Config
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
      },
    }

    -- Get capabilities from blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Helper function for root_dir patterns
    local function root_pattern(...)
      local patterns = { ... }
      return function(fname)
        for _, pattern in ipairs(patterns) do
          local found = vim.fs.find(pattern, { path = fname, upward = true })[1]
          if found then
            return vim.fs.dirname(found)
          end
        end
      end
    end

    -- LSP Attach - common keymaps for all servers
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Standard keymaps
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('gy', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('K', vim.lsp.buf.hover, 'Hover')
        map('gK', vim.lsp.buf.signature_help, 'Signature Help')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
        map('<leader>cf', function()
          vim.lsp.buf.format { async = true }
        end, '[C]ode [F]ormat')
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')

        -- Document highlight
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- Inlay hints toggle
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Server configurations
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
          },
        },
      },
      solidity_ls_nomicfoundation = {
        cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
        filetypes = { 'solidity' },
        root_dir = root_pattern('hardhat.config.ts', 'hardhat.config.js', 'foundry.toml', 'remappings.txt', '.git'),
        single_file_support = true,
      },
      gopls = {
        cmd = { 'gopls' },
        root_dir = root_pattern('go.work', 'go.mod', '.git'),
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
            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
            semanticTokens = true,
            hoverKind = 'FullDocumentation',
          },
        },
      },
      vtsls = {
        cmd = { 'vtsls', '--stdio' },
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
        },
        root_dir = root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
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
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = { completeFunctionCalls = true },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
          javascript = {
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = { completeFunctionCalls = true },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      },
      copilot = { enabled = false },
    }

    -- TypeScript-specific on_attach
    local typescript_on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      vim.keymap.set('n', '<leader>co', function()
        vim.lsp.buf.code_action {
          apply = true,
          context = { only = { 'source.organizeImports' }, diagnostics = {} },
        }
      end, vim.tbl_extend('force', opts, { desc = 'Organize Imports' }))
      vim.keymap.set('n', '<leader>cM', function()
        vim.lsp.buf.code_action {
          apply = true,
          context = { only = { 'source.addMissingImports.ts' }, diagnostics = {} },
        }
      end, vim.tbl_extend('force', opts, { desc = 'Add missing imports' }))
      vim.keymap.set('n', '<leader>cu', function()
        vim.lsp.buf.code_action {
          apply = true,
          context = { only = { 'source.removeUnused.ts' }, diagnostics = {} },
        }
      end, vim.tbl_extend('force', opts, { desc = 'Remove unused imports' }))
      vim.keymap.set('n', '<leader>cD', function()
        vim.lsp.buf.code_action {
          apply = true,
          context = { only = { 'source.fixAll.ts' }, diagnostics = {} },
        }
      end, vim.tbl_extend('force', opts, { desc = 'Fix all diagnostics' }))
    end

    -- Extend vtsls config with on_attach
    servers.vtsls.on_attach = typescript_on_attach

    -- Install tools
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, { 'stylua' })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Setup servers
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
