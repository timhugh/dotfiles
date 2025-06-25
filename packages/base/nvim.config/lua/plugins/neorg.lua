return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neorg/neorg-telescope",
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.keybinds"] = {
          config = {
            default_keybinds = false,
          }
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              journal = "~/journal",
            },
            default_workspace = "journal",
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.journal"] = {
          journal_folder = "journal",
          strategy = "%Y/%m/%d-%a",
          workspace = "journal",
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.integrations.telescope"] = {},
      },
    },
    config = function(_, opts)
      require("neorg").setup(opts)

      vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<cr>", { desc = "Neorg: Open index" })

      vim.keymap.set("n", "<leader>fn", "<cmd>Telescope neorg find_linkable<CR>", { desc = "Neorg: Search headings in telescope" })

      vim.keymap.set("n", "<leader>nn", "<cmd>Neorg journal today<cr>", { desc = "Neorg: Open today's journal entry" })
      vim.keymap.set("n", "<leader>nt", "<cmd>Neorg journal tomorrow<cr>", { desc = "Neorg: Open tomorrow's journal entry" })
      vim.keymap.set("n", "<leader>ny", "<cmd>Neorg journal yesterday<cr>", { desc = "Neorg: Open yesterday's journal entry" })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "norg",
        callback = function()
          vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<cr>", { desc = "Neorg: Return to previous note", buffer = true })

          vim.keymap.set("i", "<C-d>", "<Plug>(neorg.promo.demote.nested)", { desc = "Neorg: Demote current heading", buffer = true })
          vim.keymap.set("i", "<C-t>", "<Plug>(neorg.promo.promote.nested)", { desc = "Neorg: Promote current heading", buffer = true })
          vim.keymap.set("i", "<M-d>", "<Plug>(neorg.tempus.insert-date.insert-mode)", { desc = "Neorg: Insert date", buffer = true })

          vim.keymap.set("n", "<<", "<Plug>(neorg.promo.demote.nested)", { desc = "Neorg: Demote current heading", buffer = true })
          vim.keymap.set("n", ">>", "<Plug>(neorg.promo.promote.nested)", { desc = "Neorg: Promote current heading", buffer = true })
          vim.keymap.set("n", "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { desc = "Neorg: Cycle todo item", buffer = true })
          vim.keymap.set("n", "gf", "<Plug>(neorg.esupports.hop.hop-link.drop)", { desc = "Neorg: Hop to link", buffer = true })
          vim.keymap.set("n", "<leader>nc", "<Plug>(neorg.looking-glass.magnify-code-block)", { desc = "Neorg: Magnify code block", buffer = true })

          vim.keymap.set("v", "<", "<Plug>(neorg.promo.demote.range)", { desc = "Neorg: Demote selected headings", buffer = true })
          vim.keymap.set("v", ">", "<Plug>(neorg.promo.promote.range)", { desc = "Neorg: Promote selected headings", buffer = true })
        end,
      })
    end,
  },
  {
    "michaelb/sniprun",
    lazy = true,
    event = "VeryLazy",
    branch = "master",
    build = "bash ./install.sh",
    cmd = { "SnipRun" },
    keys = {
      { "<leader>r", "<cmd>SnipRun<cr>", desc = "SnipRun: Run code block", mode = { "n", "v" } },
    },
    opts = {},
  },
}
