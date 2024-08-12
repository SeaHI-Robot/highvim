return {
    -- amongst your other plugins
    'akinsho/toggleterm.nvim', 
    version = "*", 
    opts = {

    },
    keys = {
        { "<leader><space>", "<cmd>ToggleTerm<CR>", desc = "Toggle NvimTree", mode = { "n", "t" } },
    },
    
}
