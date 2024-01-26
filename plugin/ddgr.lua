if vim.g.loaded_ddgr == 1 then
  return
end
vim.g.loaded_ddgr = 1

local Terminal = require("toggleterm.terminal").Terminal
local ddgr = Terminal:new({ cmd = "ddgr", hidden = true })

vim.keymap.set("n", "<leader>dd", function()
  ddgr:toggle(50)
end, { desc = "DDGR" })
