return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    enabled = true,
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = {
        "codelldb",
        "delve",
        "jls",
        "kotlin-debug-adapter",
        "rdbg",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    keys = {
      { "<leader>dd", "<cmd>:DapNew<cr>",                 desc = "nvim-dap: new" },
      { "<leader>dD", "<cmd>:DapTerminate<cr>",           desc = "nvim-dap: terminate" },
      { "<leader>dc", "<cmd>:DapContinue<cr>",            desc = "nvim-dap: continue" },
      { "<leader>db", "<cmd>:DapToggleBreakpoint<cr>",    desc = "nvim-dap: toggle breakpoint" },
      { "<leader>dn", "<cmd>:DapStepOver<cr>",            desc = "nvim-dap: step over" },
      { "<leader>di", "<cmd>:DapStepInto<cr>",            desc = "nvim-dap: step into" },
      { "<leader>do", "<cmd>:DapStepOut<cr>",             desc = "nvim-dap: step out" },
      { "<leader>dr", "<cmd>:DapToggleRepl<cr>",          desc = "nvim-dap: toggle repl" },
    },
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
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "igorlfs/nvim-dap-view",
    enabled = true,
    keys = {
      { "<leader>dv", "<cmd>:DapViewToggle<cr>", desc = "nvim-dap-view: toggle" },
    },
    opts = {},
  },
}
