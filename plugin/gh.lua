if vim.g.loaded_gh == 1 then
  return
end
vim.g.loaded_gh = 1

local Terminal = require("toggleterm.terminal").Terminal
local gh = function(...)
  local cmd = table.concat({ "gh", ... }, " ")
  return Terminal:new({ cmd = cmd, close_on_exit = false, direction = "float" })
end

vim.api.nvim_create_user_command("GH", function(opts)
  gh(opts.args):toggle()
end, { desc = "GH CLI", nargs = "*" })

vim.api.nvim_create_user_command("GHClone", function()
  local res = vim.system({ "gh-clone" }):wait()
  if res.code ~= 0 then
    vim.notify(res.stderr, vim.log.levels.ERROR)
  else
    vim.notify(res.stdout)
  end
end, { desc = "Search & clone GitHub repos" })
