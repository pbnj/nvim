local Util = require("lazyvim.util")
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "https://github.com/pbnj/telescope-urls.nvim",
      keys = {
        {
          "<leader>fu",
          function()
            require("telescope").extensions.urls.urls()
          end,
          desc = "Find URLs",
        },
      },
      config = function()
        Util.on_load("telescope.nvim", function()
          require("telescope").load_extension("urls")
        end)
      end,
    },
    {
      "https://github.com/nvim-telescope/telescope-github.nvim",
      event = "VeryLazy",
      config = function()
        Util.on_load("telescope.nvim", function()
          require("telescope").load_extension("gh")
        end)
      end,
    },
  },
}
