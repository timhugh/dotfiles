-- TODO: https://github.com/nvim-telescope/telescope-frecency.nvim
return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
            vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "Grep current buffer" })
            vim.keymap.set("n", "<leader>fG", builtin.live_grep, { desc = "Grep all files" })

            vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Find in git modified files" })
            vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Find git branch" })

            vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Find references (LSP)" })
            vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find symbols in current buffer (LSP)" })
            vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Find symbols in workspace (LSP)" })
        end,
    },
    {
        "princejoogie/dir-telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("dir-telescope").setup()
        end,
        init = function()
            require("telescope").load_extension("dir")
            vim.keymap.set("n", "<leader>fdg", "<cmd>Telescope dir live_grep<CR>", { desc = "Grep all files in directory", noremap = true, silent = true })
            vim.keymap.set("n", "<leader>fdf", "<cmd>Telescope dir find_files<CR>", { desc = "Find files in directory", noremap = true, silent = true })
        end,
    }
}
