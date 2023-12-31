if vim.g.loaded_gh == 1 then
  return
end
vim.g.loaded_gh = 1

local LazyTerm = require("lazyvim.util.terminal")

vim.api.nvim_create_user_command("GH", function(opts)
  LazyTerm.open(vim.tbl_flatten({ "gh", opts.fargs }), { interactive = false, persistent = true })
end, { desc = "GH CLI", nargs = "+" })
