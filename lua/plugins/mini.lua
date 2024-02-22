return {
  "echasnovski/mini.misc",
  event = "VeryLazy",
  opts = true,
  config = function()
    require("mini.misc").setup_auto_root()
  end,
}
