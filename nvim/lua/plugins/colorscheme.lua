return {
  -- Add Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine-moon",
    priority = 1000,
    opts = {
      variant = "main",
      disable_background = true,
      styles = {
        transparency = true,
      },
    },
  },

  -- Configure LazyVim to use Rose Pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine-moon",
    },
  },
}
