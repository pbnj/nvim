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
  },
  cmd = { "G", "Git", "Gwrite", "Gw", "GBrowse" },
}
