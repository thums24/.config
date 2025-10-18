-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
-- Auto-open Telescope on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only open if no files were specified on command line
    if vim.fn.argc() == 0 then
      -- Wait for everything to load
      vim.defer_fn(function()
        -- Check if Telescope is available
        local telescope_ok, telescope = pcall(require, "telescope.builtin")
        if telescope_ok then
          telescope.find_files()
        end
      end, 100) -- 100ms delay
    end
  end,
})
