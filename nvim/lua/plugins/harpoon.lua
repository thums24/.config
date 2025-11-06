return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        '<leader>a',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Harpoon Add File',
      },
      {
        '<C-e>',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon Toggle Menu',
      },

      {
        '<C-h>',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Harpoon Navigate File 1',
      },
      {
        '<C-t>',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Harpoon Navigate File 2',
      },
      {
        '<C-n>',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Harpoon Navigate File 3',
      },
      {
        '<C-s>',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Harpoon Navigate File 4',
      },
    }

    return keys
  end,
}
