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
      indent = {
        enabled = true,
        skip_heading = true,
      },
      heading = {
        border = true,
      },
      code = {
        language_border = ' ',
        language_left = '',
        language_right = '',
        border = 'thick',
      },
      checkbox = {
        enabled = true,
        unchecked = {},
        checked = {},
        custom = {
          migrated = {
            raw = '[>]',
            rendered = '󰧛 ',
            scope_highlight = '@markup.italic',
          },
          partial = {
            raw = '[/]',
            rendered = '󰛲 ',
          },
          cancelled = {
            raw = '[~]',
            rendered = '󰅘 ',
            scope_highlight = '@markup.strikethrough',
          },
          important = {
            raw = '[!]',
            rendered = '󰄱 ',
            scope_highlight = '@markup.strong',
          },
          star = {
            raw = '[*]',
            rendered = '󰩴 ',
            scope_highlight = '@markup.strong',
          },
        },
      }
    },
  },
}
