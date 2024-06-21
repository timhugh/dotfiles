return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    keys = {
        { "<leader>t", "<cmd>:NvimTreeToggle<cr>", desc = "toggle NvimTree" },
    },
    opts = {
        update_focused_file = {
            enable = true,
        },
        actions = {
            change_dir = {
                enable = false,
                restrict_above_cwd = true,
            },
        },
    },
}

