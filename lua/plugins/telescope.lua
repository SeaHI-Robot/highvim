return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
    },
    keys = {
        { "<leader>fg", "<cmd>Telescope live_grep<CR>",   mode = { "n" }, desc = "Live Grep" },
        { "<leader>ff", "<cmd>Telescope find_files<CR>",  mode = { "n" }, desc = "Find Files" },
        { "<leader>fb", "<cmd>Telescope buffers<CR>",     mode = { "n" }, desc = "Find Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<CR>",   mode = { "n" }, desc = "Help" },
        { "<leader>fo", "<cmd>Telescope oldfiles<CR>",    mode = { "n" }, desc = "Recent Files" },
        { "<leader>fk", "<cmd>Telescope keymaps<CR>",     mode = { "n" }, desc = "Keymaps" },
        { "<leader>fc", "<cmd>Telescope colorscheme<CR>", mode = { "n" }, desc = "Change Colorscheme" },
        { "<leader>fs", "<cmd>Telescope git_status<CR>",  mode = { "n" }, desc = "Git Status" },
        {
            "<leader>fp",
            function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
            mode = { "n" },
            desc = "Find Plugin File",
        }
    },
    cmd = { "Telescopr" },
    opts = {
        defaults = {
            layout_strategy = "horizontal",
            layout_config = {
                    prompt_position = "top",
            },
            sorting_strategy = "ascending",
            winblend = 0,
        },
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
