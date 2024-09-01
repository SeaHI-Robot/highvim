return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
        require('gitsigns').setup {
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, keys, func, desc)
                    if desc then
                        desc = '[G]itsigns: ' .. desc
                    end
                    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc, noremap = true })
                end

                -- Navigation
                map('n', '<leader>gn', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '<leader>gn', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '<leader>gN', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '<leader>gN', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                -- map('n', '<leader>gsh', gitsigns.stage_hunk, 'Stage Hunk')
                map('n', '<leader>gr', gitsigns.reset_hunk, 'Reset Hunk')
                -- map('v', '<leader>gsh', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Stage Hunk')
                map('v', '<leader>gr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Reset Hunk')
                -- map('n', '<leader>gsb', gitsigns.stage_buffer, 'Stage Buffer')
                -- map('n', '<leader>gub', gitsigns.undo_stage_hunk, 'Undo Stage Hunk')
                map('n', '<leader>gR', gitsigns.reset_buffer, 'Reset Buffer')
                map('n', '<leader>gp', gitsigns.preview_hunk, 'Preview Hunk')
                -- map('n', '<leader>gb', function() gitsigns.blame_line { full = true } end, 'Blame Line')
                map('n', '<leader>gb', gitsigns.toggle_current_line_blame, 'Toggle Current Line Blame')
                map('n', '<leader>gd', gitsigns.diffthis, 'Diff This')
                -- map('n', '<leader>gD', function() gitsigns.diffthis('~') end, 'Diff This')
                map('n', '<leader>gD', gitsigns.toggle_deleted, 'Toggle Deleted')

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        }
    end

}
