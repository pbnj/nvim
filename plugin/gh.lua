if vim.g.loaded_tmux == 1 then
  return
end
vim.g.loaded_tmux = 1

local LazyTerm = require("lazyvim.util.terminal")

vim.api.nvim_create_user_command("GH", function(opts)
  local cmd = vim.tbl_flatten({ "gh", opts.fargs })
  LazyTerm.open(cmd)
end, { desc = "GH CLI", nargs = "*" })

vim.api.nvim_create_user_command("GHClone", function()
  local res = vim.system({ "gh-clone" }):wait()
  if res.code ~= 0 then
    vim.notify(res.stderr, vim.log.levels.ERROR)
  else
    vim.notify(res.stdout)
  end
end, { desc = "Search & clone GitHub repos" })
