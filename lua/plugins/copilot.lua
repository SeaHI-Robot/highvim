return {

    -- Session management. This saves your session in the background,
    -- keeping track of open buffers, window arrangement, and more.
    -- You can restore sessions when returning through the dashboard.
    {
        "github/copilot.vim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        -- keys = {
        --     { "<leader>Sr", function() require("persistence").load() end,                desc = "Restore Session" },
        --     { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
        --     { "<leader>Sd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
        -- },
        config = function()
            require("nvim-tree").setup {}
        end,
    }
}
