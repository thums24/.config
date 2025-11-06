-- Auto-open Telescope on startup
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require('telescope.builtin').find_files()
      end)
    end
  end,
})
