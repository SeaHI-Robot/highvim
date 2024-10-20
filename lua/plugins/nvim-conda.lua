return {
    "kmontocam/nvim-conda",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    ft = { "python" },
    keys = {
        { "<leader>C", "<cmd>lua print(\"nvim-conda is loaded!\")<CR>", desc = "Activate Nvim-Conda Plugin", mode = { "n" } },
    },
}
