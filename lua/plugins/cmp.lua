return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "andersevenrud/cmp-tmux" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "tmux" })
    end,
  },
}
