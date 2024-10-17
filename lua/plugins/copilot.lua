return {

    -- Session management. This saves your session in the background,
    -- keeping track of open buffers, window arrangement, and more.
    -- You can restore sessions when returning through the dashboard.
    {
        "github/copilot.vim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "<leader>Ge", "<cmd>Copilot enable<CR>",  desc = "[G]ithub Copilot [E]nable" },
            { "<leader>Gs", "<cmd>Copilot status<CR>",  desc = "[G]ithub Copilot [S]tatus" },
            { "<leader>Gd", "<cmd>Copilot disable<CR>", desc = "[G]ithub Copilot [D]isable" },
            { "<leader>Gp", "<cmd>Copilot panel<CR>",   desc = "[G]ithub Copilot [P]anel" },
        },
        config = function()
        end
    }
}
