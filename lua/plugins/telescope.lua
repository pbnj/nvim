return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "ANGkeith/telescope-terraform-doc.nvim" },
    { "cappyzawa/telescope-terraform.nvim" },
    { "nvim-telescope/telescope-github.nvim" },
  },
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
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({ hidden = true })
      end,
      desc = "Find Files",
    },
    {
      "<leader>fd",
      function()
        require("telescope.builtin").find_files({ hidden = true, cwd = "~/.dotfiles" })
      end,
      desc = "Find in Dotfiles",
    },
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = "~/Projects/", hidden = true })
      end,
      desc = "Find in Projects",
    },
    {
      "<leader>gf",
      function()
        require("telescope.builtin").git_files()
      end,
      desc = "Git Files",
    },
    {
      "<leader>gb",
      function()
        require("telescope.builtin").git_branches()
      end,
      desc = "Git Branches",
    },
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
}
