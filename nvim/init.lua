-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

--vim.cmd("lua require('catppuccin').setup(require('plugins.catppuccin').opts)")
vim.cmd("lua require('catppuccin').setup(require('plugins.catppuccin').opts())")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only show dashboard if no files were opened and no stdin
    if vim.fn.argc() == 0 and not vim.api.nvim_buf_get_name(0):match("^/") then
      vim.cmd("Dashboard")
    end
  end,
})
