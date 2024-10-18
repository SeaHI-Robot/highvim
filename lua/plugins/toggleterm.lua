return {
    -- amongst your other plugins
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 3
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.3
            end
        end,

    },
    keys = {
        { "<leader><space>", "<cmd>ToggleTerm<CR>", desc = "Toggle NvimTree: horizontal", mode = { "n", "t" } },
        -- { "<leader>v<space>", "<cmd>ToggleTerm direction=\"vertical\"<CR>", desc = "Toggle NvimTree: vertical", mode = { "n", "t" } },
    },

}
