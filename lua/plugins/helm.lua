return {
  "towolf/vim-helm",
  -- ft = { "yaml" },
  event = {
    "BufRead */templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile*.yaml",
    "BufNewFile */templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile*.yaml",
  },
}
