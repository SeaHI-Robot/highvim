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
        --     -- 和lspsage一样
        -- },
        {
            "j-hui/fidget.nvim",
            tag = "legacy",
        },
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function() -- mason需要加载的language server
        local servers = {
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
            pyright = {},
            clangd = {},
            bashls = {},
        }

        local on_attach = function(_, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('gd', require("telescope.builtin").lsp_definitions, '[G]oto [D]efinition')
            nmap('gi', require("telescope.builtin").lsp_implementations, '[G]oto [I]mplementation')
            nmap('gr', require("telescope.builtin").lsp_references, '[G]oto [R]eferences')
            nmap('K', "<cmd>Lspsaga hover_doc<CR>", 'Hover Documentation')
            nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl',
                function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end,
                '[W]orkspace [L]ist Folders')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>rn', "<cmd>Lspsaga rename<CR>", '[R]e[N]ame')
            nmap('ga', "<cmd>Lspsaga code_action<CR>", '[G] Code [A]ction')
            nmap('<leader>di', require("telescope.builtin").diagnostics, '[D]i[A]gonostics')
            nmap("<leader>f",
                function()
                    vim.lsp.buf.format { async = true }
                end,
                "[F]ormat code")
        end

        require("neoconf").setup()

        require("neodev").setup()

        require("fidget").setup()

        require("lspsaga").setup()
        vim.keymap.set({ 'n', 't' }, '<leader><space>', '<cmd>Lspsaga term_toggle<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>t', '<cmd>Lspsaga outline<CR>', { noremap = true })
        -- require("LspUI").setup()

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        settings = servers[server_name],
                        on_attach = on_attach,
                        capabilities = capabilities
                    }
                end,
            }
        })
    end
}
