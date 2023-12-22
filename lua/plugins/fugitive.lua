return {
  "tpope/vim-fugitive",
  dependencies = { "tpope/vim-rhubarb" },
  keys = {
    { "<leader>gg", "<cmd>Git<cr>", desc = "Open Fugitive Git" },
    { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git Add Current Buffer" },
  },
  cmd = { "G", "Git", "Gwrite", "Gw", "GBrowse" },
}
