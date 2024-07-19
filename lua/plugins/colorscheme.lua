return {
    -- 'shaunsingh/nord.nvim',
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --     vim.cmd([[colorscheme nord]])
    -- end

    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        vim.cmd([[colorscheme tokyonight]])
        -- colorscheme tokyonight-night
        -- colorscheme tokyonight-storm
        -- colorscheme tokyonight-day
        -- colorscheme tokyonight-moon
    end
}
