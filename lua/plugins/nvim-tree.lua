return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<C-e>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree", mode = { "n" } },
        { "<C-b>", "<cmd>NvimTreeClose<CR>", desc = "Close NvimTree", mode = { "n" } }
    },
    config = function()
        local function my_on_attach(bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            -- vim.keymap.set('n', 'h', api.tree.change_root_to_parent, opts('Parent Dir'))
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            -- vim.keymap.set('n', '<C-e>', api.tree., opts('Open nvim-tree'))
            vim.keymap.set('n', '<C-e>', api.tree.close, opts('Close nvim-tree'))
            vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy File'))
        end

        -- pass to setup along with your other options
        require("nvim-tree").setup {
            on_attach = my_on_attach,
            view = {
                width = 25,
                relativenumber = true,
            },
            filters = {
                dotfiles = false
            }
        }
        -- diable signcolumn in NvimTree
        require('nvim-tree.view').View.winopts.signcolumn = 'no'
    end,
}
