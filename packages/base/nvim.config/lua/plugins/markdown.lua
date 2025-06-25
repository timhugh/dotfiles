local types = { "markdown", "Avante", "org" }

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = true,
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      file_types = types,
    },
    ft = types,
  },
}
