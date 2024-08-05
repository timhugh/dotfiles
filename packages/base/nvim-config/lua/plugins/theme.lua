return {
    {
        "f-person/auto-dark-mode.nvim",
        dependencies = {
            "gosukiwi/vim-atom-dark",
            "rmehri01/onenord.nvim",
            "EdenEast/nightfox.nvim",
            "olimorris/onedarkpro.nvim",
        },
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                vim.api.nvim_set_option("background", "dark")
                vim.cmd("colorscheme carbonfox")
            end,
            set_light_mode = function()
                vim.api.nvim_set_option("background", "light")
                vim.cmd("colorscheme dayfox")
            end,
        },
    },
}
