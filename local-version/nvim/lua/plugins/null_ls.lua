return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function ()
        local tools = {
            "black"
        }
        require("mason-null-ls").setup({
            ensure_installed = tools,
            handlers = {},
        })

        require("null-ls").setup({
            sources = {}
        })
    end

}
