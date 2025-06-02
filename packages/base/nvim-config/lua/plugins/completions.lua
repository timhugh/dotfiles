return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
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
          -- { name = 'minuet' },
        },
        performance = {
          fetching_timeout = 2000,
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
    'milanglacier/minuet-ai.nvim',
    opts = {
      cmp = {
        enable_auto_complete = false, -- toggle to enable cmp
      },
      virtualtext = {
        auto_trigger_ft = { },
        auto_trigger_ignore_ft = {},
        keymap = {
          accept = '<c-CR>',
          accept_line = nil,
          accept_n_lines = nil,
          -- Cycle to next completion item, or manually invoke completion
          next = '<c-y>',
          -- Cycle to prev completion item, or manually invoke completion
          prev = '<c-Y>',
          dismiss = '<c-esc>',
        },
        -- Whether show virtual text suggestion when the completion menu
        -- (nvim-cmp or blink-cmp) is visible.
        show_on_completion_menu = false,
      },
      presets = {
        -- this is the default preset
        ollama = {
          provider = "openai_fim_compatible",
          context_window = 2000,
          throttle = 400,
          debounce = 100,
          stream = true,
          provider_options = {
            openai_fim_compatible = {
              api_key = 'TERM',
              name = 'Ollama',
              end_point = 'http://localhost:11434/v1/completions',
              model = 'qwen2.5-coder:7b',
              optional = {
                max_tokens = 256,
                top_p = 0.9,
              },
            },
          },
        },
        openrouter = {
          provider = "openai_compatible",
          context_window = 20000,
          request_timeout = 4,
          throttle = 3000,
          debounce = 1000,
          stream = true,
          provider_options = {
            openai_compatible = {
              model = 'google/gemini-2.5-flash-preview',
            },
          },
          model = 'google/gemini-2.5-flash-preview',
        },
      },
      provider = "openai_fim_compatible",
      context_window = 2000,
      throttle = 400,
      debounce = 100,
      provider_options = {
        openai = {
          optional = {
            max_tokens = 256,
          },
        },
        gemini = {
          optional = {
            generationConfig = {
              maxOutputTokens = 256,
              thinkingConfig = {
                thinkingBudget = 0,
              },
            },
            safetySettings = {
              category = "HARM_CATEGORY_DANGEROUS_CONTENT",
              threshold = "BLOCK_ONLY_HIGH",
            },
          },
        },
        openai_fim_compatible = {
          api_key = 'TERM',
          name = 'Ollama',
          end_point = 'http://localhost:11434/v1/completions',
          model = 'qwen2.5-coder:7b',
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "openrouter",
      auto_suggestions_provider = "openrouter",
      behavior = {
        auto_suggestions = false,
        enable_cursor_planning_mode = true,
      },
      ollama = {
        endpoint = "http://127.0.0.1:11434",
        model = "qwen2.5-coder:14b",
        disable_tools = true,
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",
        timeout = 30000,
        temperature = 0,
        max_completion_tokens = 8192,
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        temperature = 0,
        max_tokens = 4096,
      },
      vendors = {
        openrouter = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'google/gemini-2.5-flash-preview',
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}
