return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "vimdoc",
        "javascript",
        "typescript",
        "c",
        "dart",
        "lua",
        "rust",
        "jsdoc",
        "bash",
        "go",
        "solidity",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
      multiwindow = false,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
      on_attach = nil,
    },
  },
}
