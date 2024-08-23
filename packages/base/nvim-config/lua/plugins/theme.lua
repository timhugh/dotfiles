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
                vim.cmd("colorscheme onenord-light")
            end,
        },
    },
    {
        "zaldih/themery.nvim",
        config = function()
            require("themery").setup({
                themes = {
                    "atom-dark", "carbonfox", "dayfox", "desert", "evening", "koehler", "murphy", "onedark", "onelight", "pablo", "retrobox", "slate", "torte", "zaibatsu",
                    "atom-dark-256", "darkblue", "default", "duskfox", "habamax", "lunaperche", "nightfox", "onedark_dark", "onenord", "peachpuff", "ron", "sorbet", "vim", "zellner",
                    "blue", "dawnfox", "delek", "elflord", "industry", "morning", "nordfox", "onedark_vivid", "onenord-light", "quiet", "shine", "terafox", "wildcharm"
                },
                livePreview = true,
            })
        end,
    }
}
