if vim.g.loaded_ddgr == 1 then
  return
end
vim.g.loaded_ddgr = 1

local LazyTerm = require("lazyvim.util.terminal")

vim.api.nvim_create_user_command("DD", function(opts)
  local cmd = vim.tbl_flatten({ "ddgr", opts.fargs })
  LazyTerm.open(cmd)
end, { desc = "Search with DDGR", nargs = "*" })

vim.api.nvim_create_user_command("YT", function(opts)
  local res = vim.system({ "ddgr", "!yt", opts.args }):wait()
  if res.code ~= 0 then
    vim.notify(res.stderr, vim.log.levels.ERROR)
  else
    vim.notify(res.stdout, vim.log.levels.INFO)
  end
end, { desc = "Search YT with DDGR", nargs = "*" })
