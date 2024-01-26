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
      desc = "Git Add Current Buffer",
    },
    {
      "<leader>gp",
      function()
        vim.cmd("Git push --set-upstream origin")
      end,
      desc = "git push --set-upstream origin",
    },
    {
      "<leader>gb",
      function()
        vim.cmd("GBrowse")
      end,
      desc = "GBrowse",
    },
    {
      "<leader>gc",
      function()
        vim.cmd("Git commit")
      end,
      desc = "Git commit",
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
