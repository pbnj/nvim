return {
  "tpope/vim-fugitive",
  dependencies = { "tpope/vim-rhubarb" },
  keys = {
    {
      "<leader>gg",
      function()
        vim.cmd("Git")
      end,
      desc = "Fugitive",
    },
    {
      "<leader>gw",
      function()
        vim.cmd("Gwrite")
      end,
      desc = "Stage current buffer (git add)",
    },
    {
      "<leader>gp",
      function()
        vim.cmd("Git push --set-upstream origin")
      end,
      desc = "Push (git push --set-upstream origin)",
    },
    {
      "<leader>gB",
      function()
        vim.cmd("GBrowse")
      end,
      desc = "Browse repo in browser (GBrowse)",
    },
    {
      "<leader>gC",
      function()
        vim.cmd("Git commit")
      end,
      desc = "Commit (git commit)",
    },
  },
  cmd = { "G", "Git", "Gwrite", "Gw", "GBrowse" },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("lazyvim_pbnj_fugitive", { clear = true }),
      pattern = {
        "fugitive",
      },
      callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { silent = true, buffer = event.buf })
      end,
    })
  end,
}
