-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("c", "<c-n>", "<c-Down>", { noremap = true, desc = "Next Cmdline History" })
vim.keymap.set("c", "<c-p>", "<c-Up>", { noremap = true, desc = "Previous Cmdline History" })
vim.keymap.set("t", "<esc>", [[<c-\><c-n>]], { desc = "Escape in Terminal Mode" })
