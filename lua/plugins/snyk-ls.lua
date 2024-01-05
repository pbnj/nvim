return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      snyk_ls = {
        filetypes = { "javascript", "typescript", "go", "python" },
        init_options = {
          activateSnykCode = "true",
          activateSnykIac = "true",
          activateSnykOpenSource = "true",
          additionalParams = "--all-projects",
          enableTrustedFoldersFeature = "false",
          organization = vim.env.SNYK_ORG,
          token = vim.env.SNYK_TOKEN,
        },
      },
    },
  },
}
