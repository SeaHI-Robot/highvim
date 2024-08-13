return {
    "akinsho/bufferline.nvim",
    event = "BufEnter",
    -- event = "VeryLazy",
    opts = {
        options = {
            disabled_filetypes = { "alpha" },
            -- 左侧让出 nvim-tree 的位置
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "center",
                    -- separator = true
                },
            },
            diagnostics = "nvim_lsp",
            highlight = { underline = true, sp = "blue" }, -- Optional
            always_show_bufferline = true,
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
        vim.api.nvim_create_autocmd({ "BufAdd" }, {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end,
}
