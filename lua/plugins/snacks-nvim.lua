return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			width = 60,
			row = nil, -- dashboard position. nil for center
			col = nil, -- dashboard position. nil for center
			pane_gap = 8, -- empty columns between vertical panes
			autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
			preset = {
				pick = nil,
				keys = {
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						-- action = ":lua Snacks.dashboard.pick('oldfiles')",
						action = "<cmd>Telescope oldfiles<CR>",
					},
					-- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "f", desc = "Find File", action = "<cmd>Telescope find_files<CR>" },
					{
						icon = " ",
						key = "g",
						desc = "Grep Text",
						-- action = ":lua Snacks.dashboard.pick('live_grep')",
						action = "<cmd>Telescope live_grep<CR>",
					},
					-- { icon = " ", key = "e", desc = "File Explorer", action = ":lua Snacks.explorer.reveal()" },
					-- { icon = " ", key = "e", desc = "File Explorer", action = ":NvimTreeOpen" },
					{ icon = " ", key = "e", desc = "File Explorer", action = ":Neotree" },
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				header = [[


██╗  ██╗██╗ ██████╗ ██╗  ██╗██╗   ██╗██╗███╗   ███╗
██║  ██║██║██╔════╝ ██║  ██║██║   ██║██║████╗ ████║
███████║██║██║  ███╗███████║██║   ██║██║██╔████╔██║
██╔══██║██║██║   ██║██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██║██║╚██████╔╝██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║


So Far    😊    So Good
                                                  ]],
			},
			-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
			-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
			-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
			-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
			-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
			-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 2 },
				{
					pane = 2,
					icon = " ",
					title = "Clock",
					section = "terminal",
					cmd = "tty-clock -s -D ",
					indent = 2,
				},
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 3, padding = 2 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						local cwd = vim.fn.getcwd()
						local git_dir = vim.fn.systemlist("git -C " .. cwd .. " rev-parse --is-inside-work-tree")
						if git_dir[1] == "true" then
							return true
						else
							return false
						end
					end,
					cmd = "hub status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{ section = "startup" },
			},
		},
		notifier = { enabled = true, timeout = 4000 },
		explorer = { enabled = false, replace_netrw = false }, -- Replace netrw with snacks explorer
		quickfile = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = true },
		indent = {
			enabled = true,
			only_current = true,
			animate = { enabled = false },
			chunk = {
				enabled = true,
				-- hl = "Whichkey",
				char = {
					corner_top = "╭─",
					corner_bottom = "╰─",
					horizontal = "",
					vertical = "│",
					arrow = ">",
					-- arrow = "",
				},
			},
		},
		animate = { enabled = false },
		scope = { enbaled = true, underline = true, only_current = true },
		scroll = {
			enabled = false,
			animate = {
				duration = { step = 10, total = 200 },
				easing = "linear",
			},
			-- faster animation when repeating scroll after delay
			animate_repeat = {
				delay = 100, -- delay in ms before using the repeat animation
				duration = { step = 5, total = 50 },
				easing = "linear",
			},
		}, -- I don't like scroll animation, which makes me dizzy
		input = { enabled = true },
		terminal = { enabled = false }, -- I don't like scroll snacks.terminal, use toggleterm instead
		picker = {
			enabled = true,
			layout = { preset = "telescope" },
			win = {
				input = {
					keys = {
						["<a-s>"] = { "flash", mode = { "n", "i" } },
						["s"] = { "flash" },
						["<a-k>"] = { "history_forward", mode = { "i", "n" } },
						["<a-j>"] = { "history_back", mode = { "i", "n" } },
						["<Tab>"] = { "list_up", mode = { "i", "n" } },
						["<S-Tab>"] = { "list_down", mode = { "i", "n" } },
					},
				},
			},
			actions = {
				flash = function(picker)
					require("flash").jump({
						pattern = "^",
						label = { after = { 0, 0 } },
						search = {
							mode = "search",
							exclude = {
								function(win)
									return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
								end,
							},
						},
						action = function(match)
							local idx = picker.list:row2idx(match.pos[1])
							picker.list:_move(idx, true, true)
						end,
					})
				end,
			},
		}, -- I don't like picker, I prefer telescope, only use for few cases
		profiler = { enabled = true },
		styles = {
			notification = {
				wo = {
					wrap = true, -- Wrap notifications
				},
			},
			notification_history = {
				width = 0.8,
				height = 0.8,
				border = "solid",
			},
			scratch = {
				width = 0.8,
				height = 0.8,
				border = "solid",
			},
			blame_line = {
				width = 0.8,
				height = 0.8,
				border = "double",
			},
			zen = {
				enter = true,
				fixbuf = true,
				minimal = false,
				backdrop = { transparent = false, blend = 93 },
				width = 160,
			},
			input = {
				width = 35,
				relative = "cursor",
				noautocmd = false,
			},
		},
	},
    -- stylua: ignore
	keys = {
		-- { "<C-e>", function() Snacks.explorer() end, desc = "Toggle File Explorer", },
		-- { "<C-b>", function() Snacks.explorer.open() end, desc = "Toggle File Explorer", },
        { "<localleader>ps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Bufer" },
		{ "<localleader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer", },
		{ "<localleader>,", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer", },
		{ "<localleader>cr", function() Snacks.rename.rename_file() end, desc = "Change Current File Name", },
		{ "<localleader>fi", function() Snacks.picker.icons() end, desc = "Find Icons", },
		{ "<localleader>fk", function() Snacks.picker.keymaps() end, desc = "Find Keymaps", },
		{ "<localleader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", },
		{ "<localleader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)", },
		{ "<localleader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History", },
		{ "<localleader>ch", function() Snacks.picker.command_history() end, desc = "Command History", },
		{ "<localleader>hn", function() Snacks.notifier.hide() end, desc = "Hide All Notifications", },
		{ "<localleader>dn", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
		{ "<localleader>z", function() Snacks.zen.zen() end, desc = "Toggle Zen Mode", },
		{ "<localleader>ip", function() Snacks.image.hover() end, desc = "Image Preview", },
		{ "]r", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" }, },
		{ "[r", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" }, },
		{
			"<localleader>N",
			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.8,
					height = 0.8,
					wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3, },
				})
			end,
		},
	},
	init = function()
		local has_switched_mode = false
		local group = vim.api.nvim_create_augroup("SnacksInput", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "snacks_input",
			group = group,
			callback = function()
				if not has_switched_mode then
					vim.schedule(function()
						vim.cmd("stopinsert!")
						has_switched_mode = true
					end)
				end
			end,
		})
		vim.api.nvim_create_autocmd("BufLeave", {
			pattern = "*",
			group = group,
			callback = function()
				if vim.bo.filetype == "snacks_input" then
					has_switched_mode = false
				end
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command
				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<localleader>uS")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<localleader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<localleader>un")
				Snacks.toggle.diagnostics():map("<localleader>ud")
				Snacks.toggle.line_number():map("<localleader>ul")
                -- stylua: ignore
				Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }) :map("<localleader>uC")
                -- stylua: ignore
				Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }) :map("<localleader>ub")
				Snacks.toggle.inlay_hints():map("<localleader>uh")
				Snacks.toggle.dim():map("<localleader>uD")
				Snacks.toggle.indent():map("<localleader>ui")
				Snacks.toggle.treesitter():map("<localleader>uT")
				-- Toggle the profiler
				Snacks.toggle.profiler():map("<localleader>up")
				-- Toggle the profiler highlights
				Snacks.toggle.profiler_highlights():map("<localleader>uP")
				-- Toggle animation
				Snacks.toggle.scroll():map("<localleader>ua")
				-- Toggle diagnostics virtual text
                -- stylua: ignore
				Snacks.toggle.new({ id = "diag_virtual_text", name = "Diagnostics Virtual Text",
                                    get = function() return vim.diagnostic.config().virtual_text end,
                                    set = function(state)
                                        if state then vim.diagnostic.config({ virtual_text = true })
                                        else vim.diagnostic.config({ virtual_text = false })
                                        end
                                    end,
                                    }):map("<localleader>uv")
				-- Toggle cursorline
                -- stylua: ignore
                Snacks.toggle.new({ id = "cursorline", name = "Cursor Line",
                                    get = function() return vim.o.cursorline end,
                                    set = function(state) vim.o.cursorline = state end,
                                    }):map("<localleader>uL")
                -- Toggle Copilot
                -- stylua: ignore
				Snacks.toggle.new({ id = "copilot", name = "Copilot",
                                    get = function() return require("copilot.client").is_disabled() == false end,
                                    set = function(state)
                                        if state then vim.cmd("Copilot enable")
                                        else vim.cmd("Copilot disable")
                                        end
                                    end,
                                    }):map("<localleader>uG")
				-- Toggle git blame_line
                -- stylua: ignore
				Snacks.toggle.new({ id = "git_blame", name = "Git Blame",
                                    get = function() return require("gitsigns.config").config.current_line_blame end,
                                    set = function(state) require("gitsigns").toggle_current_line_blame(state) end,
                                    }):map("<localleader>ugb")
				-- Toggle gitsign column
                -- stylua: ignore
                Snacks.toggle.new({ id = "git_sign_column", name = "Git Sign Column",
                                    get = function() return require("gitsigns.config").config.signcolumn end,
                                    set = function(state) require("gitsigns").toggle_signs(state) end,
                                    }):map("<localleader>ugc")
				-- Toggle scrollbar
                -- stylua: ignore
                Snacks.toggle.new({ id = "scrollbar", name = "Scrollbar",
                                    get = function() return require("scrollbar.config").get().show end,
                                    set = function(state) require("scrollbar.utils").toggle() end,
                                    }):map("<localleader>us")
			end,
		})
	end,
}
