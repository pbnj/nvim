return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      snyk_ls = {
        filetypes = { "javascript", "typescript", "go", "python", "terraform" },
        init_options = {
          activateSnykCode = "true",
          activateSnykIac = "true",
          activateSnykOpenSource = "true",
          additionalParams = "--all-projects",
          enableTrustedFoldersFeature = "false",
          integrationName = "neovim",
          filterSeverity = { critical = true, high = true, medium = false, low = false },
          organization = vim.env.SNYK_ORG,
          token = vim.env.SNYK_TOKEN,
        },
      },
    },
  },
}
