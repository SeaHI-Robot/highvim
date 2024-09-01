return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        event = "VeryLazy",
        build = "cd app && yarn install",
        -- build = function(plugin)
        --     if vim.fn.executable "npx" then
        --         vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
        --     else
        --         vim.cmd [[Lazy load markdown-preview.nvim]]
        --         vim.fn["mkdp#util#install"]()
        --     end
        -- end,
        init = function()
            if vim.fn.executable "npx" then vim.g.mkdp_filetypes = { "markdown" } end
        end,
    },

    {
        "img-paste-devs/img-paste.vim",
        event = "VeryLazy",
        ft = { "markdown" },
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        main = "render-markdown",
        ft = { "markdown" },
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    }
}
