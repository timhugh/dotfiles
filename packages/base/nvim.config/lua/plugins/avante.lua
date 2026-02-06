return {
  {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "copilot",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
      "zbirenbaum/copilot.lua",
    },
  },
}
