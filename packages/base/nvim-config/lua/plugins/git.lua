return {
    { "airblade/vim-gitgutter" },
    {
        "f-person/git-blame.nvim",
        config = function()
            require("gitblame").setup({
                enabled = false,
            })

            vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>GitBlameToggle<cr>", { noremap = true, silent = true })
        end,
    }
}
