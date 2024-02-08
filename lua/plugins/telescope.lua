return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "ANGkeith/telescope-terraform-doc.nvim" },
    { "cappyzawa/telescope-terraform.nvim" },
    { "nvim-telescope/telescope-github.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        file_browser = {
          hidden = true,
          hijack_netrw = true,
          hide_parent_dir = true,
          grouped = true,
          prompt_path = true,
        },
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
    telescope.load_extension("file_browser")
  end,
  keys = {
    { "<leader>fe", require("telescope").extensions.file_browser.file_browser, desc = "File Explorer" },
    { "<leader>gf", require("telescope.builtin").git_files, desc = "Git Files" },
    { "<leader>gb", require("telescope.builtin").git_branches, desc = "Git Branches" },
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
        require("telescope").extensions.file_browser.file_browser({ cwd = "~/Projects/" })
      end,
      desc = "Find in Projects",
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
