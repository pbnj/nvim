local Util = require("lazyvim.util")
return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        terraform = {},
        terraform_doc = {},
      },
      pickers = {
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
    })
    telescope.load_extension("gh")
    telescope.load_extension("terraform")
    telescope.load_extension("terraform_doc")
  end,
  keys = {
    { "<leader>fp", Util.telescope("find_files", { hidden = true, cwd = "~/Projects/" }), desc = "Find in Projects" },
    { "<leader>fd", Util.telescope("find_files", { hidden = true, cwd = "~/.dotfiles/" }), desc = "Find in Dotfiles" },
    { "<leader>gb", require("telescope.builtin").git_branches, desc = "Branches (Telescope git_branches)" },
    {
      "<leader>gI",
      function()
        require("telescope").extensions.gh.issues()
      end,
      desc = "Issues (Telescope gh issues)",
    },
    {
      "<leader>gR",
      function()
        require("telescope").extensions.gh.run()
      end,
      desc = "Runs (Telescope gh run)",
    },
    {
      "<leader>gP",
      function()
        require("telescope").extensions.gh.pull_request()
      end,
      desc = "Pull Requests (Telescope gh pull_request)",
    },
    {
      "<leader>gF",
      function()
        require("telescope").extensions.gh.pull_request_files()
      end,
      desc = "Pull Request Files (Telescope gh pull_request_files)",
    },
  },
  dependencies = {
    { "ANGkeith/telescope-terraform-doc.nvim" },
    { "cappyzawa/telescope-terraform.nvim" },
    { "nvim-telescope/telescope-github.nvim" },
  },
}
