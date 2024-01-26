return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "andersevenrud/cmp-tmux" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "tmux" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { { "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim", opts = true } },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "git" })
    end,
  },
}
