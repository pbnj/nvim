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
          enableTrustedFoldersFeature = "false",
          organization = "komodohealth",
        },
      },
    },
  },
}
