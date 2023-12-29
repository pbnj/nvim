if vim.g.loaded_ddgr == 1 then
  return
end
vim.g.loaded_ddgr = 1

local LazyUtil = require("lazyvim.util")

vim.api.nvim_create_user_command("DDGR", function()
  LazyUtil.terminal.open("ddgr")
end, { nargs = "*" })
