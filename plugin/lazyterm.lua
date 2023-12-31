if vim.g.loaded_lazyterm == 1 then
  return
end
vim.g.loaded_lazyterm = 1

local LazyTerm = require("lazyvim.util.terminal")

vim.api.nvim_create_user_command("LazyTerm", function(opts)
  LazyTerm.open(opts.fargs, { persistent = true })
end, { desc = "Floating Terminal", nargs = "*" })
