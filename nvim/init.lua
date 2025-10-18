-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("nvim-highlight-colors").setup({
  render = "virtual", -- 'background', 'foreground', or 'virtual'
  virtual_symbol = "■", -- The symbol for the color square
  virtual_symbol_position = "inline", -- 'inline', 'eol', 'eow'
})
vim.cmd([[ hi Normal ctermbg=none guibg=none ]])
vim.cmd([[ hi NormalNC ctermbg=none guibg=none ]])

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "NONE" })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require("telescope.builtin").find_files()
      end)
    end
  end,
})
