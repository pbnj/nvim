if vim.g.loaded_aws == 1 then
  return
end
vim.g.loaded_aws = 1

local Terminal = require("toggleterm.terminal").Terminal

local aws_profiles = vim.fn.systemlist([[rg '\[profile (.*)\]' -or '$1' ~/.aws/config]])

vim.api.nvim_create_user_command("AWSLogin", function()
  vim.ui.select(aws_profiles, { prompt = "AWS Profile" }, function(profile)
    if profile then
      local res = vim.system({ "aws", "sso", "login", "--profile", profile }):wait()
      if res.code ~= 0 then
        vim.notify(res.stderr, vim.log.levels.ERROR)
      end
      vim.notify(res.stdout)
    end
  end)
end, { desc = "AWS SSO Login" })

vim.api.nvim_create_user_command("AWSConsole", function()
  vim.ui.select(aws_profiles, { prompt = "AWS Profile" }, function(profile)
    if profile then
      local sso = vim.system({ "aws", "sso", "login", "--profile", profile }):wait()
      if sso.code ~= 0 then
        vim.notify(sso.stderr, vim.log.levels.ERROR)
      end
      local console = vim.system({ "aws-console", "-p", profile }):wait()
      if console.code ~= 0 then
        vim.notify(console.stderr, vim.log.levels.ERROR)
      end
    end
  end)
end, { desc = "Launch AWS web console" })

vim.api.nvim_create_user_command("AWSGimmeCreds", function()
  vim.ui.input({ prompt = "AWS IAM Roles" }, function(role)
    local cmd = "gimme-aws-creds"
    if role then
      cmd = string.format("gimme-aws-creds --roles /%s/", role)
    end
    Terminal:new({ cmd = cmd, close_on_exit = false }):toggle()
  end)
end, { desc = "gimme-aws-creds" })

vim.api.nvim_create_user_command("AWSWhich", function()
  local aws_profile_id = vim.fn.systemlist([[sed -nr 's/\[profile (.*)\] # (.*)/\1 : \2/p' ~/.aws/config]])
  vim.ui.select(aws_profile_id, { prompt = "Find AWS Account by ID or Alias" }, function(acct)
    if acct then
      vim.notify(acct)
      vim.fn.setreg("*", acct)
    end
  end)
end, { desc = "Find AWS Account by ID or Alias" })
