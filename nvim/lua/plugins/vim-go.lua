return {
  {
    "fatih/vim-go",
    run = ":GoUpdateBinaries",
    config = function()
      -- Optional: additional vim-go configuration here
      vim.g.go_fmt_command = "goimports" -- or "gofmt"
      -- CRITICAL: Disable vim-go's K mapping so LSP hover works
      vim.g.go_doc_keywordprg_enabled = 0

      -- Disable other conflicting mappings
      vim.g.go_def_mapping_enabled = 0

      -- Let LSP handle these features
      vim.g.go_code_completion_enabled = 0
      vim.g.go_gopls_enabled = 0
    end,
  },
}
