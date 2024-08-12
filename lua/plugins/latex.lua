return {
    "lervag/vimtex",
    -- lazy = false, -- we don't want to lazy load VimTeX
    -- ft = { "markdown", "tex" },
    ft = { "tex" },
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "zathura"
        -- vimtex config
        -- \ll开启连续编译，\lv预览pdf，\lc清除文件
        -- 参考https://castel.dev/post/lecture-notes-1/
        vim.g.tex_flavor = 'latex'
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_compiler_latexmk_engines = { ['_'] = '-xelatex' }
        vim.g.vimtex_compiler_latexrun_engines = { ['_'] = 'xelatex' }
        vim.g.vimtex_quickfix_mode = 0
        vim.opt.conceallevel = 1
        vim.g.tex_conceal = 'abdmg'
    end

}
