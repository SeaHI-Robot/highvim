return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "zeioth/none-ls-autoload.nvim",
        },
        ft = {
            "python"
        },
        event = { "BufReadPost", "BufNewFile" },
        -- event = { "VeryLazy" },
        config = function()
            local tools = {
                "black"
            }
            require("none-ls-autoload").setup({
                ensure_installed = tools,
                handlers = {},
            })

            require("null-ls").setup({
                sources = {}
            })
        end
    },
    {
        "zeioth/none-ls-autoload.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
        opts = {},
    }
}
