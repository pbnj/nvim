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
    telescope.load_extension("urls")
  end,
  keys = {
    { "<leader>gB", require("telescope.builtin").git_branches, desc = "Telescope git_branches" },
    { "<leader>gC", require("telescope.builtin").git_commits, desc = "Telescope git_commits" },
    { "<leader>;", require("telescope.builtin").command_history, desc = "Telescope command_history" },
    { "<leader>:", require("telescope.builtin").commands, desc = "Telescope commands" },
    { "<leader>fh", require("telescope.builtin").help_tags, desc = "Telescope help_tags" },
    { "<leader>fp", Util.telescope("find_files", { hidden = true, cwd = "~/Projects/" }), desc = "Find Projects" },
    {
      "<leader>fgi",
      function()
        require("telescope").extensions.gh.issues()
      end,
      desc = "Telescope gh issues",
    },
    {
      "<leader>fgr",
      function()
        require("telescope").extensions.gh.run()
      end,
      desc = "Telescope gh run",
    },
    {
      "<leader>fgp",
      function()
        require("telescope").extensions.gh.pull_request()
      end,
      desc = "Telescope gh pull_request",
    },
    {
      "<leader>fgP",
      function()
        require("telescope").extensions.gh.pull_request_files()
      end,
      desc = "Telescope gh pull_request_files",
    },
    {
      "<leader>fT",
      function()
        require("telescope").extensions.terraform.state_list()
      end,
      desc = "Telescope terraform state_list",
    },
    {
      "<leader>ft",
      function()
        require("telescope").extensions.terraform_doc.terraform_doc()
      end,
      desc = "Telescope terraform_doc",
    },
    {
      "<leader>fu",
      function()
        require("telescope").extensions.urls.urls()
      end,
      desc = "Find URLs",
    },
  },
  dependencies = {
    { "ANGkeith/telescope-terraform-doc.nvim" },
    { "cappyzawa/telescope-terraform.nvim" },
    { "nvim-telescope/telescope-github.nvim" },
    { "pbnj/telescope-urls.nvim" },
  },
}
