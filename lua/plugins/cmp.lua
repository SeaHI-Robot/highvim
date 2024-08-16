return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        {
            "saadparwaiz1/cmp_luasnip",
            dependencies = {
                "L3MON4D3/LuaSnip",
                version = "v2.3.0", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- dependencies = {
                --     "rafamadriz/friendly-snippets"
                -- }
            }
        },
    },
    event = "VeryLazy",
    -- ft = {
    --     "c",
    --     "cpp",
    --     "lua",
    --     "vim",
    --     "markdown",
    --     "tex",
    --     "yaml",
    --     "json",
    --     "toml",
    --     "bash",
    --     "javascript",
    --     "cmake",
    --     "snippets"},
    config = function()
        -- 使用snipmate的snippet格式，并加载vim-snippets和我的snipmate的snippets的路径
        require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snippets/my_snippets/", "~/.config/nvim/snippets/vim-snippets/" } })

        -- load snippets from path/of/your/nvim/config/my-cool-snippets, 目标目录需要包含package.json
        require("luasnip.loaders.from_vscode").load({ paths = { "~/.vscode/High-ROS-Snippets/" } })

        local luasnip = require("luasnip")
        local cmp = require("cmp")

        local function border(hl_name)
            return {
                { "╭", hl_name },
                { "─", hl_name },
                { "╮", hl_name },
                { "│", hl_name },
                { "╯", hl_name },
                { "─", hl_name },
                { "╰", hl_name },
                { "│", hl_name },
            }
        end

        local formatting_style = {
            format = function(_, item)
                local icons = {
                    Namespace = "󰌗",
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰆧",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈚",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "󰊄",
                    Table = "",
                    Object = "󰅩",
                    Tag = "",
                    Array = "[]",
                    Boolean = "",
                    Number = "",
                    Null = "󰟢",
                    Supermaven = "",
                    String = "󰉿",
                    Calendar = "",
                    Watch = "󰥔",
                    Package = "",
                    Copilot = "",
                    Codeium = "",
                    TabNine = "",
                }
                local icon = icons[item.kind]

                -- icon = " " .. icon .. " "
                icon = " " .. icon
                -- item.menu = "   (" .. item.kind .. ")"
                item.menu = " " .. item.kind
                item.kind = icon

                return item
            end,
        }

        cmp.setup {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            sources = cmp.config.sources {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'luasnip' },
                { name = "buffer" },
            },
            mapping = cmp.mapping.preset.insert {
                -- Tab 跳转到下一个补全项
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                -- Shift + Tab 跳转到上一个补全项
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                -- Down 跳转到下一个补全项
                ["<Down>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                -- Up 跳转到上一个补全项
                ["<Up>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                -- 确认补全选项
                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    else
                        fallback()
                    end
                end),
                -- 文档翻页
                ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                -- 取消补全
                ['<leader>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() })
            },
            window = {
                completion = {
                    side_padding = 1, -- 1 or 0
                    -- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
                    scrollbar = true,
                    border = border "CmpDocBorder"
                },
                documentation = {
                    border = border "CmpDocBorder",
                    winhighlight = "Normal:CmpDoc",
                },
            },
            formatting = formatting_style,
            experimental = {
                ghost_text = true,
            }
        }

        -- /搜索的时候进行补全
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            }
        })

        -- 命令行进行补全
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline' }
            })
        })

        -- nvim-autopairs config
        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
    end,
}
