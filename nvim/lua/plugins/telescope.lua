return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        enabled = vim.fn.executable 'make' == 1,
      },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          -- Your default settings here if needed
        },
      }

      -- Load extensions
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
}
