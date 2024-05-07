local M = {}

function M.run(policy)
  local Terminal = require("toggleterm.terminal").Terminal
  local cmd = string.format(
    "custodian run --verbose --output-dir ./tmp/ --region all %s",
    policy
  )
  Terminal:new({ cmd = cmd, close_on_exit = false }):toggle()
end

function M.report(policy)
  local Terminal = require("toggleterm.terminal").Terminal
  local cmd = string.format(
    "custodian report --verbose --output-dir ./tmp/ --region all %s",
    policy
  )
  Terminal:new({ cmd = cmd, close_on_exit = false }):toggle()
end

vim.api.nvim_create_user_command("C7nRun", function(opts)
  M.run(opts.args)
end, { nargs = 1, complete = "file_in_path" })

vim.api.nvim_create_user_command("C7nReport", function(opts)
  M.report(opts.args)
end, { nargs = 1, complete = "file_in_path" })
