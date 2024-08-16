return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            local opts = {
                options         = {
                    -- theme = "auto",
                    theme = 'nord',
                    -- theme = 'tokyonight',
                    -- theme = 'catppuccin',
                    -- theme = 'catppuccin-frappe',
                    -- theme = 'catppuccin-mocha',
                    disabled_filetypes = { 'packer', 'NvimTree', statusline = { 'dashboard', 'alpha' } },
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
                        {
                            'diagnostics',
                            symbols = {
                                error = " ",
                                warn  = " ",
                                hint  = " ",
                                info  = " "
                            }
                        },
                        {
                            'diff',
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
                            end,
                        },
                        -- { 'encoding', icon_only = true, separator = "" },
                        -- 'fileformat',
                    },
                    lualine_y = { { "progress", separator = "" },
                        { "location", icon = "", padding = { left = 1, right = 1 } },
                    },
                    lualine_z = { function()
                        return " " .. os.date("%R")
                    end, }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline         = {},
                winbar          = {},
                inactive_winbar = {},
                extensions      = { "nvim-tree", "lazy" }
            }
            if vim.g.trouble_lualine then
                local trouble = require("trouble")
                local symbols = trouble.statusline({
                    mode = "symbols",
                    groups = {},
                    title = false,
                    filter = { range = true },
                    format = "{kind_icon}{symbol.name:Normal}",
                    hl_group = "lualine_c_normal",
                })
                table.insert(opts.sections.lualine_c, {
                    symbols and symbols.get,
                    cond = function()
                        return vim.b.trouble_lualine ~= false and symbols.has()
                    end,
                })
            end

            return opts
        end,
    },
}
