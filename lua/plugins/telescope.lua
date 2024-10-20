return {

    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            config = function()
                require('telescope').load_extension('fzf')
            end
        },
    },
    keys = {
        { "<leader>fg",  "<cmd>Telescope live_grep<CR>",            mode = { "n" }, desc = "Live Grep" },
        { "<leader>fF",  "<cmd>Telescope git_files<CR>",            mode = { "n" }, desc = "Find in Git Files" },
        { "<leader>ff",  "<cmd>Telescope find_files<CR>",           mode = { "n" }, desc = "Find Files" },
        { "<leader>fb",  "<cmd>Telescope buffers<CR>",              mode = { "n" }, desc = "Find Buffers" },
        { "<leader>fh",  "<cmd>Telescope help_tags<CR>",            mode = { "n" }, desc = "Help" },
        { "<leader>fr",  "<cmd>Telescope oldfiles<CR>",             mode = { "n" }, desc = "Recent Files" },
        { "<leader>fk",  "<cmd>Telescope keymaps<CR>",              mode = { "n" }, desc = "Keymaps" },
        { "<leader>fc",  "<cmd>Telescope colorscheme<CR>",          mode = { "n" }, desc = "Change Colorscheme" },
        { "<leader>fG", "<cmd>Telescope git_status<CR>",           mode = { "n" }, desc = "Git Status" },
        { "<leader>fds", "<cmd>Telescope lsp_document_symbols<CR>", mode = { "n" }, desc = "Search Document Symbols" },
        { "<leader>fws", "<cmd>Telescope git_status<CR>",           mode = { "n" }, desc = "Search Workspace Symbols" },
        {
            "<leader>fp",
            function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
            mode = { "n" },
            desc = "Find Plugin File",
        }
    },
    cmd = { "Telescope" },
    opts = {
        defaults = {
            layout_strategy = "horizontal",
            layout_config = {
                prompt_position = "top",
                -- preview_cutoff = 120,
            },
            sorting_strategy = "ascending",
            winblend = 0,
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            }
        }
    },
    config = function()
        require('telescope').setup({
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case"
                }
            },
        })
    end
}
