return {
  "folke/zen-mode.nvim",
  dependencies = { "folke/twilight.nvim" },
  opts = {
    window = {
      width = 1,
      height = 1,
      options = {
        number = false,
      },
    },
    plugins = {
      tmux = {
        enabled = true,
      },
    },
  },
  keys = {
    {
      "<leader>zz",
      function()
        require("zen-mode").toggle()
      end,
      desc = "Zen Mode",
    },
  },
}
