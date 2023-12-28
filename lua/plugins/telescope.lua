local Util = require("lazyvim.util")
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>gb", require("telescope.builtin").git_branches, desc = "Git Branches (Telescope)" },
    { "<leader>fd", Util.telescope("git_files", { cwd = "~/.dotfiles/" }), desc = "Dotfiles" },
    { "<leader>fp", Util.telescope("find_files", { cwd = "~/Projects/", hidden = true }), desc = "Projects" },
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
