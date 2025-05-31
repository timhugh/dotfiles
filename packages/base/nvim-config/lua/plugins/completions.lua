return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      'tzachar/cmp-ai',
      'hrsh7th/cmp-nvim-lsp',
    },
    opts = function()
      local cmp = require('cmp')
      return {
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'codeium' },
          { name = 'cmp_ai' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
      }
    end
  },
  {
    'tzachar/cmp-ai',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = function()
      local cmp_ai = require('cmp_ai.config')
      cmp_ai:setup({
        max_lines = 1000,
        provider = 'OpenAI',
        provider_options = {
          model = 'gpt-4',
        },
        notify = true,
        notify_callback = function(msg)
          vim.notify(msg)
        end,
        run_on_every_keystroke = true,
        ignored_file_types = {
        },
      })
    end,
  },
{
  "Exafunction/windsurf.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
    })
  end
},
}
