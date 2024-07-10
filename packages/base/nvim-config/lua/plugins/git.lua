return {
    { "airblade/vim-gitgutter" },
    {
        "FabijanZulj/blame.nvim",
        config = function()
            require("blame").setup()

            vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>BlameToggle<cr>", { noremap = true, silent = true })
        end
    }
}
