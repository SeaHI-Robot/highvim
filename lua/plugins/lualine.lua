return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'nord',
                    -- theme = 'tokyonight',
                    -- theme = 'catppuccin-frappe',
                    disabled_filetypes = { 'packer', 'NvimTree' },
                    fmt = string.lower,
                },
                -- sections = {
                    -- lualine_c = {
                    --     'lsp_progress'
                    -- }
                -- }
            }
        end,
    },
    -- {
    --     "arkav/lualine-lsp-progress",
    --     dependencies = { "nvim-lualine/lualine.nvim" },
    --     event = "VeryLazy",
    -- }
}
