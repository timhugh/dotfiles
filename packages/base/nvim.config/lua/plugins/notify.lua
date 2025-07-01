return {
  {
    "rcarriga/nvim-notify",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>fN",
        function()
          require("telescope").extensions.notify.notify()
        end,
        desc = "Find Notifications",
      },
    },
    config = function()
      vim.notify = require("notify")

      require('telescope').load_extension('notify')
    end,
  },
}
