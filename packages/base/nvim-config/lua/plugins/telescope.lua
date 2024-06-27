-- TODO: https://github.com/nvim-telescope/telescope-frecency.nvim
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    init = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
        vim.keymap.set("n", "<leader>fla", builtin.current_buffer_fuzzy_find, { desc = "Find text in current buffer" })
        vim.keymap.set("n", "<leader>fG", builtin.live_grep, { desc = "Grep all files" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help page"} )
        vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Find in quickfix list" })

        vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Find in git modified files" })
        vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Find git branch" })

        vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Find symbols in current buffer (Treesitter)" })

        vim.keymap.set("n", "<leader>flr", builtin.lsp_references, { desc = "Find references (LSP)" })
        vim.keymap.set("n", "<leader>fli", builtin.lsp_incoming_calls, { desc = "Find incoming calls (LSP)" })
        vim.keymap.set("n", "<leader>flo", builtin.lsp_outgoing_calls, { desc = "Find outgoing calls (LSP)" })
        vim.keymap.set("n", "<leader>fls", builtin.lsp_document_symbols, { desc = "Find symbols in current buffer (LSP)" })
        vim.keymap.set("n", "<leader>flS", builtin.lsp_workspace_symbols, { desc = "Find symbols in workspace (LSP)" })
    end,
}

