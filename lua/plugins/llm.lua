-- 在视觉模式下映射一个键来执行上述函数
vim.api.nvim_set_keymap('v', '<leader>U', ':lua print_selected_text()<CR>', { noremap = true, silent = true })
return {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSesionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
        local tools = require("llm.common.tools")
        local F = require("llm.common.func")
        local Popup = require("nui.popup")
        local NuiText = require("nui.text")
        local Layout = require("nui.layout")

        -- create your layout
        local function CreateLayout(_width, _height, boxes, opts)
            local options = {
                relative = "editor",
                position = "50%",
                size = {
                    width = _width,
                    height = _height,
                },
            }
            options = vim.tbl_deep_extend("force", options, opts or {})
            return Layout(options, boxes)
        end

        -- Set the properties of the pop-up window.
        local function SetBoxOpts(box_list, opts)
            for i, v in ipairs(box_list) do
                vim.api.nvim_set_option_value("filetype", opts.filetype[i], { buf = v.bufnr })
                vim.api.nvim_set_option_value("buftype", opts.buftype, { buf = v.bufnr })
                vim.api.nvim_set_option_value("spell", opts.spell, { win = v.winid })
                vim.api.nvim_set_option_value("wrap", opts.wrap, { win = v.winid })
                vim.api.nvim_set_option_value("linebreak", opts.linebreak, { win = v.winid })
                vim.api.nvim_set_option_value("number", opts.number, { win = v.winid })
            end
        end

        -- My Custom App Handler
        local function interact_handler(name, _, state, streaming)
            local selected_text = F.GetVisualSelection()
            local prompt = [[阅读代码或文本: ]]

            local input_box = Popup({
                enter = true,
                border = {
                    style = "solid",
                    text = {
                        top = NuiText(" 󱜙 Interact ", "CurSearch"),
                        top_align = "center",
                    },
                },
            })

            local separator = Popup({
                border = { style = "none" },
                enter = false,
                focusable = false,
                win_options = { winblend = 0, winhighlight = "Normal:Normal" },
            })

            local preview_box = Popup({
                focusable = true,
                border = { style = "solid", text = { top = "", top_align = "center" } },
            })

            local layout = CreateLayout(
                "80%",
                "75%",
                Layout.Box({
                    Layout.Box(input_box, { size = "10%" }),
                    Layout.Box(separator, { size = "5%" }),
                    Layout.Box(preview_box, { size = "85%" }),
                }, { dir = "col" })
            )

            layout:mount()
            vim.api.nvim_command("startinsert")

            SetBoxOpts({ preview_box }, {
                filetype = { "markdown", "markdown" },
                buftype = "nofile",
                spell = false,
                number = false,
                wrap = true,
                linebreak = false,
            })

            local worker = { job = nil }

            state.app["session"][name] = {}
            input_box:map("n", "<enter>", function()
                -- clear preview_box content [optional]
                vim.api.nvim_buf_set_lines(preview_box.bufnr, 0, -1, false, {})

                local input_table = vim.api.nvim_buf_get_lines(input_box.bufnr, 0, -1, true)
                local input = table.concat(input_table, "\n")

                -- clear input_box content
                vim.api.nvim_buf_set_lines(input_box.bufnr, 0, -1, false, {})
                if input ~= "" then
                    table.insert(state.app.session[name],
                        { role = "user", content = prompt .. "\n" .. selected_text .. "\n请" .. input })
                    state.popwin = preview_box
                    worker = streaming(preview_box.bufnr, preview_box.winid, state.app.session[name])
                end
            end)

            input_box:map("n", { "J", "K" }, function()
                vim.api.nvim_set_current_win(preview_box.winid)
            end)
            preview_box:map("n", { "J", "K" }, function()
                vim.api.nvim_set_current_win(input_box.winid)
            end)

            for _, v in ipairs({ input_box, preview_box }) do
                v:map("n", { "<esc>", "N", "n" }, function()
                    if worker.job then
                        worker.job:shutdown()
                        print("Suspend output...")
                        vim.wait(200, function() end)
                        worker.job = nil
                    end
                    layout:unmount()
                end)

                v:map("n", { "Y", "y" }, function()
                    vim.api.nvim_set_current_win(preview_box.winid)
                    vim.api.nvim_command("normal! ggVGky")
                    layout:unmount()
                end)
            end
        end

        require("llm").setup({

            -- app_handler
            app_handler = {
                OptimizeCode = {
                    handler = tools.side_by_side_handler,
                },

                -- modify the prompt and options
                TestCode = {
                    handler = tools.side_by_side_handler,
                    prompt = "Write a test for the following code, only return the test code:",
                    opts = {
                        right = {
                            title = " Result ",
                        },
                    },
                },
                OptimCompare = {
                    handler = tools.action_handler,
                },
                Translate = {
                    handler = tools.qa_handler,
                },
                Interact = {
                    handler = interact_handler,
                }
            },

            -- ChatGLM
            max_tokens = 4096,
            url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
            model = "glm-4-flash",

            -- UI Settings
            save_session = true,
            max_history = 15,
            prefix = {
                user = { text = "😃  ", hl = "Title" },
                assistant = { text = "   ", hl = "Added" },
                -- assistant = { text = "⚡ ", hl = "Added" },
            },
            input_box_opts = {
                relative = "editor",
                position = {
                    row = "85%",
                    col = 15,
                },
                size = {
                    height = "5%",
                    width = 120,
                },

                enter = true,
                focusable = true,
                zindex = 50,
                border = {
                    style = "rounded",
                    text = {
                        top = " Enter Your Question ",
                        top_align = "center",
                    },
                },
                win_options = {
                    -- set window transparency
                    winblend = 10,
                    -- set window highlight
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
            },
            output_box_opts = {
                style = "float", -- right | left | above | below | float
                relative = "editor",
                position = {
                    row = "35%",
                    col = 15,
                },
                size = {
                    height = "65%",
                    width = 90,
                },
                enter = true,
                focusable = true,
                zindex = 20,
                border = {
                    style = "rounded",
                    text = {
                        top = " Preview ",
                        top_align = "center",
                    },
                },
                win_options = {
                    winblend = 10,
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
            },

            history_box_opts = {
                relative = "editor",
                position = {
                    row = "35%",
                    col = 108,
                },
                size = {
                    height = "65%",
                    width = 27,
                },
                zindex = 70,
                enter = false,
                focusable = false,
                border = {
                    style = "rounded",
                    text = {
                        top = " History ",
                        top_align = "center",
                    },
                },
                win_options = {
                    winblend = 10,
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
            },

            -- LLMSelectedTextHandler windows options
            popwin_opts = {
                relative = "cursor",
                position = {
                    row = -7,
                    col = 20,
                },
                size = {
                    width = "50%",
                    height = 35,
                },
                enter = true,
                border = {
                    style = "rounded",
                    text = {
                        top = " Explain ",
                    },
                },
            },

            -- stylua: ignore
            keys = {
                -- The keyboard mapping for the input window.
                ["Input:Submit"]      = { mode = "n", key = "<cr>" },
                ["Input:Cancel"]      = { mode = "n", key = "<C-c>" },
                ["Input:Resend"]      = { mode = "n", key = "<C-r>" },

                -- only works when "save_session = true"
                ["Input:HistoryNext"] = { mode = "n", key = "<C-j>" },
                ["Input:HistoryPrev"] = { mode = "n", key = "<C-k>" },

                -- The keyboard mapping for the output window in "split" style.
                ["Output:Ask"]        = { mode = "n", key = "i" },
                ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
                ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

                -- The keyboard mapping for the output and input windows in "float" style.
                ["Session:Toggle"]    = { mode = "n", key = "<leader>l" },
                ["Session:Close"]     = { mode = "n", key = "<esc>" },
            },
        })
    end,
    keys = {
        { "<leader>L", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Toggle LLMSession" },
        { "<leader>ll", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Toggle LLMSession" },
        { "<leader>le", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>", desc = "LLM: Explain Selected Code" },
        { "<leader>lt", mode = "v", "<cmd>LLMSelectedTextHandler 英译汉<cr>", desc = "LLM: Translate into Chinese" },
        { "<leader>lT", mode = "n", "<cmd>LLMAppHandler Translate<cr>", desc = "LLM: Open a Translating Window [Chinese to English]" },
        { "<leader>li", mode = "x", "<cmd>LLMAppHandler Interact<cr>", desc = "LLM: Interact about the Selected Text" },
        { "<leader>lc", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>", desc = "LLM: Optimize Selected Code then Compare" },
        { "<leader>lo", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>", desc = "LLM: Optimize Selected Code" },
        -- { "<leader>ltc", mode = "x", "<cmd>LLMAppHandler TestCode<cr>" },
    },
}
