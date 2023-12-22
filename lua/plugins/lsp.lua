return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      snyk_ls = {
        filetypes = { "javascript", "json", "yaml", "go" },
        init_options = {
          activateSnykCode = "true",
          activateSnykIac = "true",
          activateSnykOpenSource = "true",
          enableTrustedFoldersFeature = "false",
          organization = "komodohealth",
        },
      },
    },
  },
}
