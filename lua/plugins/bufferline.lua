return {
    "akinsho/bufferline.nvim",
    event = "BufEnter",
    -- event = "VeryLazy",
    opts = {
        disabled_filetypes = { "alpha" },
    },
    config = function()
        require("bufferline").setup({
            options = {
                -- TODO: 改成lazy样式。
                -- 使用 nvim 内置lsp
                diagnostics = "nvim_lsp",
                -- 标题同时显示错误和警告
                -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
                --     local s = " "
                --     for e, n in pairs(diagnostics_dict) do
                --         local sym = e == "error" and " "
                --             or (e == "warning" and " " or "")
                --         s = s .. n .. sym
                --     end
                --     return s
                -- end,
                -- 左侧让出 nvim-tree 的位置
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "center"
                    },
                },
                -- -- 动态显示关闭键
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' }
                },
            }
        })
    end,
}
