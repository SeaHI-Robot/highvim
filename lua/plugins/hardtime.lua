return {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
        disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
        disabled_keys = {
            ["<Left>"] = { "i" },
            ["<Right>"] = { "i" },
            ["<Up>"] = { "i" },
            ["<Down>"] = { "i" },
        },
        enabled = false,
    },
    keys = {
        {
            "<leader>H",
            function()
                require("hardtime").toggle()
                vim.notify("Hardtime is Toggled")
            end,
            desc = "Toggle Hardtime",
            mode = { "n" }
        },
    },
    -- config = function()
    --     require("hardtime").setup(
    --         {enabled = false}
    --     )
    -- end
}
