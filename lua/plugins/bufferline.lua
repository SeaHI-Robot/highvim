return {
    "akinsho/bufferline.nvim",
    -- event = "BufEnter",
    event = "VeryLazy",
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
        { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete Other Buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
        { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
        { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
        { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
        { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
        { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
        { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
        { "<leader><Tab>",         "<cmd>bnext<cr>",               desc = "Next Buffer" },
    },
    opts = {
        options = {
            disabled_filetypes = { "alpha", "dashboard" },
            -- 左侧让出 nvim-tree 的位置
            offsets = {
                {
                    filetype = "NvimTree",
                    -- text = "File Explorer",
                    text = "NvimTree",
                    highlight = "Directory",
                    text_align = "center",
                    -- separator = true
                },
            },
            diagnostics = "nvim_lsp",
            highlight = { underline = true, sp = "blue" }, -- Optional
            always_show_bufferline = false,
            -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
            --     local s = " "
            --     for e, n in pairs(diagnostics_dict) do
            --         local sym = e == "error" and " "
            --             or (e == "warning" and " " or "")
            --         s = s .. n .. sym
            --     end
            --     return s
            -- end,
            hover = {
                enabled = true,
                delay = 200,
                reveal = { 'close' }
            },
            -- separator_style = "slope",
            numbers = function(opts)
                return string.format('%s.', opts.lower(opts.ordinal))
            end,

        }
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end,
}
