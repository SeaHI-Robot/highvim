return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    -- keys = {
    --     { "<leader>A", "<cmd>Alpha<CR>",   mode = { "n" }, desc = "Open Alpha-Nvim Dashboard" },
    -- },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header
        dashboard.section.header.val = {
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                Welcome to HighVim !                 ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
            "                                                     ",
        }

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
            -- dashboard.button("f", "󰈞  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
            dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
            dashboard.button("q", "  > Quit", ":qa<CR>"),
            {
                type = "text",
                val = "",
            },
            {
                type = "text",
                val = "",
            },
            {
                type = "text",
                val = "",
            },
            {
                type = "text",
                val = "",
            },
        }


        -- Send config to alpha
        alpha.setup(dashboard.opts)



        -- Disable folding on alpha buffer
        vim.cmd([[
                    autocmd FileType alpha setlocal nofoldenable

                ]])

        vim.api.nvim_create_autocmd("User", {
            once = true,
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "⚡ Neovim loaded "
                    .. stats.loaded
                    .. "/"
                    .. stats.count
                    .. " plugins in "
                    .. ms
                    .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            desc = "Disable status and tabline for alpha",
            callback = function()
                vim.go.laststatus = 0
                vim.opt.showtabline = 0
            end,
        })
        vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            desc = "Enable status and tabline after alpha",
            callback = function()
                vim.go.laststatus = 3
                vim.opt.showtabline = 2
            end,
        })
    end,
}
