return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }

      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch scene",
          project = "${workspaceFolder}",
          launch_scene = true,
        },
      }

      vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>")
      vim.keymap.set("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>")
      vim.keymap.set("n", "<leader>dn", "<cmd>lua require('dap').step_over()<cr>")
      vim.keymap.set("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>")
      vim.keymap.set("n", "<leader>do", "<cmd>lua require('dap').step_out()<cr>")
      vim.keymap.set("n", "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>")
    end,
  },
}
