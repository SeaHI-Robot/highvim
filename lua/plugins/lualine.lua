return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        config = function()
            require('lualine').setup {
                options         = {
                    theme = 'nord',
                    -- theme = 'tokyonight',
                    -- theme = 'catppuccin',
                    -- theme = 'catppuccin-frappe',
                    -- theme = 'catppuccin-mocha',
                    disabled_filetypes = { 'packer', 'NvimTree' },
                    fmt = string.lower,
                    component_separators = { left = '', right = '' },
                    -- component_separators = { left = '', right = '' },
                    -- component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    -- section_separators = { left = '', right = '' },
                },
                sections        = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        { 'branch', separator = "" },
                    },
                    lualine_c = {
                        { 'filename', separator = "" },
                        { "filetype", icon_only = true, separator = "", padding = { left = 0, right = 0 } },
                    },
                    lualine_x = {
                        -- 'encoding', 'fileformat',
                        { 'diagnostics', symbols = {
                            error = " ",
                            warn  = " ",
                            hint  = " ",
                            info  = " " } },
                        { 'diff',
                            symbols = {
                                added    = " ",
                                modified = " ",
                                removed  = " ",
                            },
                            source = function()
                                local gitsigns = vim.b.gitsigns_status_dict
                                if gitsigns then
                                    return {
                                        added = gitsigns.added,
                                        modified = gitsigns.changed,
                                        removed = gitsigns.removed,
                                    }
                                end
                            end, }
                    },
                    lualine_y = { { "progress", separator = "" },
                        { "location", icon = "", padding = { left = 1, right = 1 } },
                    },
                    lualine_z = { function()
                        return " " .. os.date("%R")
                    end, }
                },
                -- inactive_sections = {
                --     lualine_a = {},
                --     lualine_b = {},
                --     lualine_c = { 'filename' },
                --     lualine_x = { 'location' },
                --     lualine_y = {},
                --     lualine_z = {}
                -- },
                tabline         = {},
                winbar          = {},
                inactive_winbar = {},
                extensions      = {}
            }
        end,
    },
    -- {
    --     "arkav/lualine-lsp-progress",
    --     dependencies = { "nvim-lualine/lualine.nvim" },
    --     event = "VeryLazy",
    -- }
}
