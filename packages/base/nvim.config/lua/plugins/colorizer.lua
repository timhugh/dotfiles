return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    enabled = true,
    opts = {
      lazy_load = true,
      filetypes = { "*" },
      user_default_options = {
        names = true,
        names_opts = {
          lowercase = true,
          camelcase = true,
          uppercase = true,
          strip_digits = false,
        },
        RGB = true,       -- #RGB hex codes
        RGBA = true,      -- #RGBA hex codes
        RRGGBB = true,    -- #RRGGBB hex codes
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = false,   -- CSS rgb() and rgba() functions
        hsl_fn = false,   -- CSS hsl() and hsla() functions
        tailwind = "lsp", -- options are boolean|"normal"|"lsp"|"both" (true is "normal")
        -- "normal" will use the default tailwind config
        -- "lsp" will get custom colors from the LSP
        -- "both" will combine the two
        tailwind_opts = {
          -- this must be set to true to use LSP results
          update_names = true,
        },
      },
    },
    config = function(opts)
      require("colorizer").setup({opts})
    end,
  }
}
