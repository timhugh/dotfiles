return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        "zidhuss/neotest-minitest",
        "olimorris/neotest-rspec"
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-minitest"),
                require("neotest-rspec"),
            }
        })

        vim.api.nvim_set_keymap("n", "<leader>tt", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<leader>to", ':lua require("neotest").output.open()<CR>', {noremap = true, silent = true})
    end,
}
