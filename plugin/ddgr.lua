if vim.g.loaded_ddgr == 1 then
  return
end
vim.g.loaded_ddgr = 1

local LazyTerm = require("lazyvim.util.terminal")

vim.api.nvim_create_user_command("DDGR", function(opts)
  LazyTerm.open(vim.tbl_flatten({ "ddgr", opts.fargs }))
end, { nargs = "*" })
