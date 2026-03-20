return {
  {
    "f-person/auto-dark-mode.nvim",
    enabled = true,
    dependencies = {
      "gosukiwi/vim-atom-dark",
      "rmehri01/onenord.nvim",
      "EdenEast/nightfox.nvim",
      "olimorris/onedarkpro.nvim",
      "folke/tokyonight.nvim",
      "catppuccin/nvim",
      "rebelot/kanagawa.nvim",
      "Mofiqul/vscode.nvim",
      "projekt0n/github-nvim-theme",
    },
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.opt.background = "dark"
        vim.cmd("colorscheme carbonfox")
      end,
      set_light_mode = function()
        vim.opt.background = "light"
        vim.cmd("colorscheme onenord-light")
      end,
    },
  },
  {
    "zaldih/themery.nvim",
    enabled = true,
    config = function()
      require("themery").setup({
        themes = {
          -- dark: builtin
          "blue", "darkblue", "default", "desert", "elflord", "evening", "habamax", "industry",
          "koehler", "lunaperche", "murphy", "pablo", "ron", "slate", "sorbet", "torte", "vim",
          "wildcharm", "zaibatsu",
          -- dark: gosukiwi/vim-atom-dark
          "atom-dark", "atom-dark-256",
          -- medium: rmehri01/onenord.nvim
          "onenord",
          -- dark: EdenEast/nightfox.nvim
          "carbonfox", "duskfox",
          -- dark: olimorris/onedarkpro.nvim
          "onedark_dark",
          -- dark: folke/tokyonight.nvim
          "tokyonight",
          -- dark: catppuccin/nvim
          "catppuccin", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha",
          -- dark: rebelot/kanagawa.nvim
          "kanagawa", "kanagawa-dragon", "kanagawa-wave",
          -- Mofiqul/vscode.nvim
          "vscode",
          -- projekt0n/github-nvim-theme
          "github_dark", "github_dark_dimmed", "github_dark_default", "github_dark_high_contrast",
          "github_dark_colorblind", "github_dark_tritanopia",
          -- medium: EdenEast/nightfox.nvim
          "nightfox", "nordfox", "terafox",
          -- medium: olimorris/onedarkpro.nvim
          "onedark", "onedark_vivid",
          -- medium: folke/tokyonight.nvim
          "tokyonight-moon", "tokyonight-night", "tokyonight-storm",
          -- light: builtin
          "delek", "morning", "peachpuff", "quiet", "retrobox", "shine", "zellner",
          -- light: olimorris/onedarkpro.nvim
          "onelight",
          -- light: folke/tokyonight.nvim
          "tokyonight-day",
          -- light: catppuccin/nvim
          "catppuccin-latte",
          -- light: rebelot/kanagawa.nvim
          "kanagawa-lotus",
          -- light: projekt0n/github-nvim-theme
          "github_light", "github_light_default", "github_light_high_contrast", "github_light_colorblind",
          "github_light_tritanopia",
          -- light: rmehri01/onenord.nvim
          "onenord-light",
          -- light: EdenEast/nightfox.nvim
          "dawnfox", "dayfox",
        },
        livePreview = true,
      })
    end,
  }
}
