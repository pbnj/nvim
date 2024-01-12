local Util = require("lazyvim.util")
return {
  "nvim-telescope/telescope.nvim",
  config = function()
    require("telescope").setup({
      pickers = {
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
    })
  end,
  keys = {
    { "<leader>gB", require("telescope.builtin").git_branches, desc = "Telescope git_branches" },
    { "<leader>gC", require("telescope.builtin").git_commits, desc = "Telescope git_commits" },
    {
      "<leader>gb",
      function()
        vim.cmd("Git browse")
      end,
      desc = "Git browse",
    },
    {
      "<leader>gc",
      function()
        vim.cmd("Git commit")
      end,
      desc = "Git commit",
    },
    { "<leader>fd", Util.telescope("git_files", { cwd = "~/.dotfiles/" }), desc = "Dotfiles" },
  },
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
      config = function()
        Util.on_load("telescope.nvim", function()
          require("telescope").load_extension("gh")
        end)
      end,
    },
  },
}
