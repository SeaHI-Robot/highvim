return {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        -- { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } Not work here, I add this keybind in lua/core/keymaps.lua
    },
    config = function()
        -- require("telescope").load_extension("lazygit")
    end
}
