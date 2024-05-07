vim.api.nvim_create_user_command("Snyk", function(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local cmd = string.format("snyk %s", opts.args)
  Terminal:new({
    cmd = cmd,
    close_on_exit = false,
  }):toggle()
end, { nargs = "*", complete = "file_in_path" })
