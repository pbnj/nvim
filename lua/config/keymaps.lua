-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("c", "<c-n>", "<c-Down>", { noremap = true, desc = "Next Cmdline History" })
vim.keymap.set("c", "<c-p>", "<c-Up>", { noremap = true, desc = "Previous Cmdline History" })
vim.keymap.set("t", "<esc>", [[<c-\><c-n>]], { desc = "Escape in Terminal Mode" })
vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv", { desc = "Move visual line down & reindent" })
vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv", { desc = "Move visual line up & reindent" })

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
  vim.keymap.set("t", "<s-space>", " ")
  vim.keymap.set("t", "<s-cr>", "<cr>")
end
