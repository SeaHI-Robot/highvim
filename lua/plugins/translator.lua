return {
    'voldikss/vim-translator',
    event = "VeryLazy",
    keys = {
        { "<C-t>", "<cmd>TranslateW<CR>", desc = "Translate a Word", mode = { "n" } },
    },
    config = function()
        vim.g.translator_default_engines = { 'bing' }
        -- ['bing', 'google', 'haici', 'youdao']
    end
}
