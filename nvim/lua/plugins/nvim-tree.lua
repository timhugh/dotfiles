require('nvim-tree').setup({
    update_focused_file = {
        enable = true,
    },
    actions = {
        change_dir = {
            enable = false,
            restrict_above_cwd = true,
        },
    },
})

vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

