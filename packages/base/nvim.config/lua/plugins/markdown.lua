local types = { "markdown", "Avante" }

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = true,
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    ft = types,
    opts = {
      file_types = types,
      checkbox = {
        enabled = true,
        custom = {
          partial = {
            raw = '[/]',
            rendered = '󱋭 ',
          },
          cancelled = {
            raw = '[~]',
            rendered = '~ ',
            scope_highlight = '@markup.strikethrough',
          },
          important = {
            raw = '[!]',
            rendered = '󰄱 ',
            scope_highlight = '@markup.strong',
          },
        },
      }
    },
  },
}
