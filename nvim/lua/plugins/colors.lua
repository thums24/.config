function ColorMyPencils(color)
  color = color or 'rose-pine-moon'
  vim.cmd.colorscheme(color)

  -- General transparency
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

  -- Telescope transparency - must be set AFTER colorscheme
  vim.schedule(function()
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = 'none' })
  end)
end

return {
  {
    'erikbackman/brightburn.vim',
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    opts = {},
    config = function()
      ColorMyPencils()
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000, -- Load this first!
    config = function()
      require('rose-pine').setup {
        disable_background = true,
        styles = {
          italic = false,
        },
      }
      ColorMyPencils()
    end,
  },
}
