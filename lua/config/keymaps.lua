-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("c", "<c-n>", "<c-Down>", { noremap = true, desc = "Next Cmdline History" })
vim.keymap.set("c", "<c-p>", "<c-Up>", { noremap = true, desc = "Previous Cmdline History" })

if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
  -- Allow clipboard copy paste in neovim
  vim.keymap.set("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.keymap.set("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.keymap.set("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.keymap.set("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
end
