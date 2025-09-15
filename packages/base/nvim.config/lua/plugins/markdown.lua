local types = { "markdown", "Avante" }

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = false,
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
  {
    "3rd/image.nvim",
    enabled = true,
    build = false,
    opts = {
      processor = "magick_cli",
    }
  },
  {
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    opts = {
      -- Disable automatic rendering for manual-only workflow
      events = {
        render_buffer = {}, -- Empty = no automatic rendering
        clear_buffer = { "BufLeave" },
      },
      renderer_options = {
        mermaid = {
          background = "transparent",
          theme = "neutral",
        },
      },
    },
    keys = {
      {
        "<leader>md",
        function()
          require("diagram").show_diagram_hover()
        end,
        mode = "n",
        ft = { "markdown" },
        desc = "Show diagram in new tab",
      },
    },
  },
}
