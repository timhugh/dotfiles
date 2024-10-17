return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",

            "zidhuss/neotest-minitest",
            "olimorris/neotest-rspec",
            "fredrikaverpil/neotest-golang",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-minitest"),
                    require("neotest-rspec")({
                        rspec_cmd = function(position_type)
                            if position_type == "test" then
                                return vim.tbl_flatten({
                                    "bundle", "exec", "rspec", "--fail-fast",
                                })
                            else
                                return vim.tbl_flatten({
                                    "bundle", "exec", "rspec",
                                })
                            end
                        end
                    }),
                    require("neotest-golang"),
                }
            })

            vim.api.nvim_set_keymap("n", "<leader>tt", ':lua require("neotest").run.run()<CR>', {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<leader>tf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<leader>to", ':lua require("neotest").output.open()<CR>', {noremap = true, silent = true})
        end,
    }
}
