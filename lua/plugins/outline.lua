return {
    "hedyhli/outline.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>o", "<cmd>Outline<CR>", desc = "Open mini.files (Directory of Current File)", mode = { "n" } },
    },
    config = function()
        -- Example mapping to toggle outline
        -- vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
        --     { desc = "Toggle Outline" })
        --
        require("outline").setup {
            -- Your setup opts here (leave empty to use defaults)
        }
    end,
}
