return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local colors = require("rose-pine.palette")
    return {
      options = {
        theme = {
          normal = {
            a = { fg = colors.love, bg = colors.base },
            b = { fg = colors.subtle, bg = colors.base },
            c = { fg = colors.text, bg = colors.base },
          },
          insert = { a = { fg = colors.foam, bg = colors.base } },
          visual = { a = { fg = colors.iris, bg = colors.base } },
          replace = { a = { fg = colors.gold, bg = colors.base } },
          inactive = {
            a = { fg = colors.text, bg = colors.base },
            b = { fg = colors.subtle, bg = colors.base },
            c = { fg = colors.subtle, bg = colors.base },
          },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "filename" },
        lualine_c = {},
        lualine_x = { "diagnostics", "filetype" },
        lualine_y = { "location" },
        lualine_z = {},
      },
      extensions = {},
    }
  end,
}
