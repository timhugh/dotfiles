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
    },
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
        vim.cmd("colorscheme carbonfox")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
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
          -- default themes
          "blue",
          "darkblue",
          "default",
          "delek",
          "desert",
          "elflord",
          "evening",
          "habamax",
          "industry",
          "koehler",
          "lunaperche",
          "morning",
          "murphy",
          "pablo",
          "peachpuff",
          "quiet",
          "retrobox",
          "ron",
          "shine",
          "slate",
          "sorbet",
          "torte",
          "vim",
          "wildcharm",
          "zaibatsu",
          "zellner",
          -- gosukiwi/vim-atom-dark
          "atom-dark", "atom-dark-256",
          -- rmehri01/onenord.nvim
          "onenord", "onenord-light",
          -- EdenEast/nightfox.nvim
          "carbonfox", "dawnfox", "dayfox", "duskfox", "nightfox", "nordfox", "terafox",
          -- olimorris/onedarkpro.nvim
          "onedark", "onedark_dark", "onedark_vivid", "onelight",
          -- folke/tokyonight.nvim
          "tokyonight", "tokyonight-day", "tokyonight-moon", "tokyonight-night", "tokyonight-storm",
          -- catppuccin/nvim
          "catppuccin", "catppuccin-frappe", "catppuccin-latte", "catppuccin-macchiato", "catppuccin-mocha",
          -- rebelot/kanagawa.nvim
          "kanagawa", "kanagawa-dragon", "kanagawa-lotus", "kanagawa-wave",
          -- Mofiqul/vscode.nvim
          "vscode"
        },
        livePreview = true,
      })
    end,
  }
}
