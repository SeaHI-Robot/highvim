return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- add any options here
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = false,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,       -- add a border to hover docs and signature help
            },
            -- show macro messages, otherwise noice.lua does not do 
            vim.api.nvim_create_autocmd("RecordingEnter", {
                callback = function()
                    local msg = string.format("Register:  %s", vim.fn.reg_recording())
                    _MACRO_RECORDING_STATUS = true
                    vim.notify(msg, vim.log.levels.INFO, {
                        title = "Macro Recording",
                        keep = function() return _MACRO_RECORDING_STATUS end,
                    })
                end,
                group = vim.api.nvim_create_augroup("NoiceMacroNotfication", { clear = true })
            }),
            vim.api.nvim_create_autocmd("RecordingLeave", {
                callback = function()
                    _MACRO_RECORDING_STATUS = false
                    vim.notify("Success!", vim.log.levels.INFO, {
                        title = "Macro Recording End",
                        timeout = 2000,
                    })
                end,
                group = vim.api.nvim_create_augroup("NoiceMacroNotficationDismiss", { clear = true })
            })
        })
    end
}
