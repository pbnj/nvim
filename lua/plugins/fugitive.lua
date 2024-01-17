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
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "fugitive",
      },
      callback = function()
        vim.keymap.set("n", "q", "<cmd>q<cr>", { silent = true, buffer = true })
      end,
    })
  end,
}
