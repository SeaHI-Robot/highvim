return {
    'voldikss/vim-translator',
    event = "VeryLazy",
    config = function()
        vim.g.translator_default_engines = { 'bing' }
        -- ['bing', 'google', 'haici', 'youdao']
        -- -- Configuration example
        vim.keymap.set('n', '<C-t>', '<cmd>TranslateW<CR>', { noremap = true, desc = "Translate a Word" })
        vim.keymap.set('v', '<C-t>', '<cmd>TranslateWV<CR>', { noremap = true, desc = "Translate a Word" })
    end
}
