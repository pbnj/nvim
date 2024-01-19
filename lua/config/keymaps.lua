-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("c", "<c-n>", "<c-Down>", { noremap = true, desc = "Next Cmdline History" })
vim.keymap.set("c", "<c-p>", "<c-Up>", { noremap = true, desc = "Previous Cmdline History" })
vim.keymap.set("t", "<esc>", [[<c-\><c-n>]], { desc = "Escape in Terminal Mode" })

if vim.g.neovide then
  vim.keymap.set("!", "<D-v>", "<C-R>+")
  vim.keymap.set("c", "<D-v>", "<C-R>+")
  vim.keymap.set("i", "<D-v>", "<C-R>+")
  vim.keymap.set("n", "<D-s>", "<cmd>w<CR>")
  vim.keymap.set("n", "<D-v>", '"+P')
  vim.keymap.set("n", "<D-]>", "gt")
  vim.keymap.set("n", "<D-[>", "gT")
  vim.keymap.set("v", "<D-c>", '"+y')
  vim.keymap.set("v", "<D-v>", "<C-R>+")
end
