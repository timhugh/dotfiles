local function select_env()
  require("telescope").extensions.rest.select_env()
end

return {
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>RE", select_env, desc = "Select REST environment" },
      { "<leader>RO", "<cmd>Rest open<cr>", desc = "REST: Open result pane" },
      { "<leader>RR", "<cmd>Rest run<cr>", desc = "REST: Run request under cursor" },
    },
    init = function()
      require("telescope").load_extension("rest")
    end,
  },
}
