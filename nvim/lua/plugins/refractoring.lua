return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  config = function()
    require("refactoring").setup({
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
        typescript = false,
        javascript = false,
        dart = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
        typescript = false,
        javascript = false,
        dart = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = false,
    })

    -- load refactoring Telescope extension
    require("telescope").load_extension("refactoring")

    -- Telescope refactoring menu
    vim.keymap.set({ "n", "x" }, "<leader>rr", function()
      require("telescope").extensions.refactoring.refactors()
    end, { desc = "Refactoring menu" })
  end,
}
