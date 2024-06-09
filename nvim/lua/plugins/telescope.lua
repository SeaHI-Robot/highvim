return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
    },
    keys = {
        {"<leader>fg", "<cmd>Telescope live_grep<CR>", mode = { "n" }},
        {"<leader>ff", "<cmd>Telescope find_files<CR>", mode = { "n" }},
        {"<leader>fb", "<cmd>Telescope buffers<CR>", mode = { "n" }},
        {"<leader>fh", "<cmd>Telescope help_tags<CR>", mode = { "n" }},
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
            }
        })
        require('telescope').load_extension('fzf')
    end

}
