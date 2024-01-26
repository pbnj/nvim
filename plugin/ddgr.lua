if vim.g.loaded_ddgr == 1 then
  return
end
vim.g.loaded_ddgr = 1

local Terminal = require("toggleterm.terminal").Terminal
local ddgr = function(...)
  local cmd = table.concat({ "ddgr", ... }, " ")
  return Terminal:new({ cmd = cmd })
end

vim.api.nvim_create_user_command("Lofi", function(opts)
  local args = opts.args or "lofi"
  ddgr("--url-handler", "mpv", "--site", "youtube.com", args):toggle(40)
end, { desc = "Search and play LoFi from YT with DDGR + MPV", nargs = "*" })

vim.api.nvim_create_user_command("DD", function(opts)
  ddgr(opts.args):toggle(40)
end, { desc = "Search with DDGR", nargs = "*" })

vim.api.nvim_create_user_command("YT", function(opts)
  local res = vim.system({ "ddgr", "!yt", opts.args }):wait()
  if res.code ~= 0 then
    vim.notify(res.stderr, vim.log.levels.ERROR)
  else
    vim.notify(res.stdout, vim.log.levels.INFO)
  end
end, { desc = "Search YT with DDGR", nargs = "*" })

vim.keymap.set("n", "<leader>dd", function()
  ddgr():toggle(40)
end, { desc = "DDGR" })
