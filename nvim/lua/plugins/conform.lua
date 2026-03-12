return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports', 'golines' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      solidity = { 'prettier' },
    },
    -- All settings must be inside 'opts' to be passed to setup()
    formatters = {
      golines = {
        prepend_args = { '--max-len=120', '--base-formatter=gofmt' },
      },
      prettier = {
        -- Force the solidity plugin for .sol files
        prepend_args = { '--plugin', 'prettier-plugin-solidity' },
      },
    },
    format_on_save = {
      -- Increased timeout to prevent goimports 'WARN' timeouts
      timeout_ms = 2000,
      lsp_fallback = true,
    },
  },
}
