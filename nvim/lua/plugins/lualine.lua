return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    -- Use the base Catppuccin theme and tweak mode colors
    local catppuccin = require("lualine.themes.catppuccin")
    catppuccin.normal.a.bg = "#eccc81"
    catppuccin.insert.a.bg = "#FF6600"
    catppuccin.command.a.bg = "#CAA75E" -- Example: a yellow shade from your palette
    catppuccin.visual.a.bg = "#986794" -- Example: mauve
    catppuccin.replace.a.bg = "#EC5E66" -- Example: red

    return {
      options = {
        theme = catppuccin,
        -- ...other options
      },
      -- ...any other lualine options
    }
  end,
}
