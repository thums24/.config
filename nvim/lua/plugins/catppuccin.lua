local base = {
  red = "#ff657a",
  maroon = "#F29BA7",
  peach = "#FF6600", -- Hermes orange
  yellow = "#eccc81",
  green = "#a8be81",
  teal = "#9cd1bb",
  sky = "#A6C9E5",
  sapphire = "#86AACC",
  blue = "#5d81ab",
  lavender = "#66729C",
  mauve = "#b18eab",
}
local extend_base = function(value)
  return vim.tbl_extend("force", base, value)
end
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Make sure it loads before other UI plugins
  opts = function()
    return {
      background = {
        dark = "frappe",
        light = "latte",
      },
      color_overrides = {
        latte = extend_base({
          text = "#202027",
          subtext1 = "#263168",
          subtext0 = "#4c4f69",
          overlay2 = "#737994",
          overlay1 = "#838ba7",
          base = "#fcfcfa",
          mantle = "#EAEDF3",
          crust = "#DCE0E8",
          pink = "#EA7A95",
          mauve = "#986794",
          red = "#EC5E66",
          peach = "#FF6600", -- Hermes orange for light theme
          yellow = "#CAA75E",
          green = "#004225",
        }),
        frappe = extend_base({
          text = "#fcfcfa",
          surface2 = "#535763",
          surface1 = "#3a3d4b",
          surface0 = "#30303b",
          base = "#202027",
          mantle = "#1c1d22",
          crust = "#171719",
          peach = "#FF6600", -- Hermes orange for dark theme
        }),
      },
      custom_highlights = function(colors)
        return {
          -- Dashboard ASCII art (common dashboard plugins)
          DashboardHeader = { fg = colors.peach },
          AlphaHeader = { fg = colors.peach },
          StartifyHeader = { fg = colors.peach },
        }
      end,
    }
  end,
  config = function(_, opts)
    -- Handle both function and table opts
    local resolved_opts = type(opts) == "function" and opts() or opts
    require("catppuccin").setup(resolved_opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
