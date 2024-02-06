-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = "terraform",
  group = vim.api.nvim_create_augroup("lazyvim_pbnj_terraform_keymap", { clear = true }),
  callback = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>ct"] = {
        name = "+Terraform",
        s = {
          function()
            require("telescope").extensions.terraform.state_list()
          end,
          "State (Telescope terraform state_list)",
        },
        d = {
          function()
            require("telescope").extensions.terraform_doc.terraform_doc()
          end,
          "Docs (Telescope terraform_doc)",
        },
      },
    })
  end,
})
