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
  },
  formatters = {
    golines = {
      prepend_args = { '--max-len=120', '--base-formatter=gofmt' }, -- customise line length
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
