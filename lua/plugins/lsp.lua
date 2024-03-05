return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      snyk_ls = {
        filetypes = { "javascript", "typescript", "go", "python", "terraform", "helm" },
        init_options = {
          activateSnykCode = "true",
          activateSnykIac = "true",
          activateSnykOpenSource = "true",
          additionalParams = "--all-projects",
          enableTrustedFoldersFeature = "false",
          integrationName = "neovim",
          filterSeverity = { critical = true, high = true, medium = true, low = true },
          organization = vim.env.SNYK_ORG,
          token = vim.env.SNYK_TOKEN,
        },
      },
      -- temporary fix for https://github.com/hashicorp/terraform-ls/issues/1655
      terraformls = {
        init_options = {
          terraform = {
            path = vim.fs.normalize("~/.local/share/nvim/mason/bin/terraform-ls"),
          },
        },
      },
    },
  },
}
