return {
    {
        'shaunsingh/nord.nvim',
        lazy = true,
        -- priority = 1000,
        -- config = function()
        --     vim.cmd([[colorscheme nord]])
        -- end
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        -- priority = 1000,
        opts = { style = "moon" },
        -- config = function()
        -- vim.cmd([[colorscheme tokyonight]])
        -- colorscheme tokyonight-night
        -- colorscheme tokyonight-storm
        -- colorscheme tokyonight-day
        -- colorscheme tokyonight-moon
        -- end
    },
    {
        "catppuccin/nvim",
        -- lazy = true,
        name = "catppuccin",
        priority = 1000,
        opts = {
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                grug_far = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            }
        },
        config = function()
            vim.cmd.colorscheme "catppuccin-frappe"
        end
        -- config = function()
        --     require("catppuccin").setup({
        --         flavour = "auto", -- latte, frappe, macchiato, mocha
        --         background = { -- :h background
        --             light = "latte",
        --             dark = "mocha",
        --         },
        --         transparent_background = false, -- disables setting the background color.
        --         show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        --         term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        --         dim_inactive = {
        --             enabled = false, -- dims the background color of inactive window
        --             shade = "dark",
        --             percentage = 0.15, -- percentage of the shade to apply to the inactive window
        --         },
        --         no_italic = false,  -- Force no italic
        --         no_bold = false,    -- Force no bold
        --         no_underline = false, -- Force no underline
        --         styles = {          -- Handles the styles of general hi groups (see `:h highlight-args`):
        --             comments = { "italic" }, -- Change the style of comments
        --             conditionals = { "italic" },
        --             loops = {},
        --             functions = {},
        --             keywords = {},
        --             strings = {},
        --             variables = {},
        --             numbers = {},
        --             booleans = {},
        --             properties = {},
        --             types = {},
        --             operators = {},
        --             -- miscs = {}, -- Uncomment to turn off hard-coded styles
        --         },
        --         color_overrides = {},
        --         custom_highlights = {},
        --         default_integrations = true,
        --         integrations = {
        --             cmp = true,
        --             gitsigns = true,
        --             nvimtree = true,
        --             treesitter = true,
        --             notify = false,
        --             mini = {
        --                 enabled = true,
        --                 indentscope_color = "",
        --             },
        --             -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        --         },
        --     })

        -- setup must be called before loading
        -- vim.cmd.colorscheme "catppuccin"
        -- vim.cmd.colorscheme "catppuccin-frappe"
        -- end
    }
}