return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neoconf.nvim",
        "folke/neodev.nvim",
        "nvimdev/lspsaga.nvim",
        -- {
        --     "jinzhongjia/LspUI.nvim",
        --     branch = "main",
        --     -- 和 lspsage 中UI组件类似的功能
        -- },
        {
            "j-hui/fidget.nvim",
            tag = "legacy",
        },
        -- "SmiteshP/nvim-navbuddy",
        -- dependencies = {
        --     "SmiteshP/nvim-navic",
        --     "MunifTanjim/nui.nvim"
        -- },
        -- opts = { lsp = { auto_attach = true } }
        -- "navbuddy": 类似ranger、yazi的outline导航插件
    },
    event = { "BufReadPost", "BufNewFile" },
    ft = { "lua", "python", "cmake", "cpp", "c", "mardown", "tex", "json", "yaml" },
    cmd = { "Mason" },
    keys = {
        { "<leader>f<space>", "<cmd>Lspsaga term_toggle<CR>", desc = "Toggle FLoat Termial <Lspsaga>", mode = { "n", "t" } },
        { "<leader>O",        "<cmd>Lspsaga outline<CR>",     desc = "Toggle Outline <Lspsaga>",       mode = { "n" } },
    },
    config = function() -- mason需要加载的language server
        local servers = {
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
            -- ========== Python LSP ========== -- 
            jedi_language_server = {

            },
            -- pyright = {
            --     python = {
            --         analysis = {
            --             typeCheckingMode = "off",
            --             autoSearchPaths = true,
            --             useLibraryDorTypes = true
            --         }
            --     }
            -- },
            ruff_lsp = {},
            -- ========== Python LSP ========== -- 
            clangd = {},
            bashls = {},
            vimls = {},
            matlab_ls = {},
            cmake = {},
            jsonls = {}
        }

        -- local navbuddy = require("nvim-navbuddy")

        local on_attach = function(_, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true })
            end
            -- navbuddy.attach(_, bufnr)

            nmap('gD', "<cmd>Lspsaga peek_definition<CR>", 'Peek [D]eclaration ')
            nmap('gd', require("telescope.builtin").lsp_definitions, '[G]oto [D]efinition')
            nmap('gi', require("telescope.builtin").lsp_implementations, '[G]oto [I]mplementation')
            nmap('gr', require("telescope.builtin").lsp_references, '[G]oto [R]eferences')
            nmap('K', "<cmd>Lspsaga hover_doc<CR>", 'Hover Documentation')
            -- nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')
            -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            -- nmap('<leader>wl',
            --     function()
            --         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            --     end,
            --     '[W]orkspace [L]ist Folders')
            nmap('<leader>d', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>D', "<cmd>Lspsaga peek_type_definition<CR>", 'Type [D]efinition')
            nmap('<leader>rn', "<cmd>Lspsaga rename<CR>", '[R]e[N]ame')
            -- nmap('<leader>rn', "<cmd>Lspsaga rename ++project<CR>", '[R]e[N]ame')
            -- nmap('<leader>ca', "<cmd>Lspsaga code_action<CR>", '[C]ode [A]ction')
            nmap('<leader>da', require("telescope.builtin").diagnostics, '[D]i[A]gonostics')
            nmap("<leader>F",
                function()
                    vim.lsp.buf.format { async = true }
                end,
                "[F]ormat code")
        end

        require("neoconf").setup()

        require("neodev").setup()

        require("fidget").setup()

        require("lspsaga").setup({
            lightbulb = {
                enable = false,
            },
        })

        --
        -- require("LspUI").setup()

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            opts = function(_, opts)
                table.insert(opts.ensure_installed, "black")
            end,
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
            -- handlers = {
            --     function(server_name) -- default handler (optional)
            --         require("lspconfig")[server_name].setup {
            --             settings = servers[server_name],
            --             on_attach = on_attach,
            --             capabilities = capabilities
            --         }
            --     end,
            -- }
        })

        for server, config in pairs(servers) do
            require("lspconfig")[server].setup(
                vim.tbl_deep_extend("keep",
                    {
                        on_attach = on_attach,
                        capabilities = capabilities
                    },
                    config
                )
            )
        end
    end
}
