-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Flutter Tools
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope flutter commands<cr>", { desc = "Flutter Tools Menu" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })

vim.keymap.set("n", "<leader>br", function()
  vim.cmd("20new")
  vim.cmd("te fvm flutter packages pub run build_runner build --delete-conflicting-outputs")
  vim.cmd("2sleep | normal G")
end, { desc = "Build Runner" })

vim.keymap.set({ "n", "x" }, "<leader>re", function()
  return require("refactoring").refactor("Extract Function")
end, { expr = true })
vim.keymap.set({ "n", "x" }, "<leader>rf", function()
  return require("refactoring").refactor("Extract Function To File")
end, { expr = true })
vim.keymap.set({ "n", "x" }, "<leader>rv", function()
  return require("refactoring").refactor("Extract Variable")
end, { expr = true })
vim.keymap.set({ "n", "x" }, "<leader>rI", function()
  return require("refactoring").refactor("Inline Function")
end, { expr = true })
vim.keymap.set({ "n", "x" }, "<leader>ri", function()
  return require("refactoring").refactor("Inline Variable")
end, { expr = true })

vim.keymap.set({ "n", "x" }, "<leader>rbb", function()
  return require("refactoring").refactor("Extract Block")
end, { expr = true })
vim.keymap.set({ "n", "x" }, "<leader>rbf", function()
  return require("refactoring").refactor("Extract Block To File")
end, { expr = true })
