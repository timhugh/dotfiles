return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "zbirenbaum/copilot.lua",
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanion<cr>", desc = "Code Companion" },
      { "<leader>aa", "<cmd>CodeCompanion chat<cr>", desc = "Code Companion Chat" },
      { "<leader>ai", "<cmd>CodeCompanion inline<cr>", desc = "Code Companion Inline" },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
          model = "gpt-4.1" ,
        },
        inline = {
          adapter = "copilot",
        },
      },
      display = {
        action_palette = {
          provider = "telescope",
        },
      },
    },
  },
}
