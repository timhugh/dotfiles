return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    keys = {
        { "<leader>O", "<cmd>:NvimTreeToggle<cr>", desc = "toggle NvimTree" },
        { "<leader>o", "<cmd>:NvimTreeFocus<cr>", desc = "focus NvimTree" },
        { "<c-t>", "<cmd>:tabnew %<cr>:NvimTreeFocus<cr>", desc = "open NvimTree in new tab" },
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
        view = {
            adaptive_size = true,
        },
    },
}

