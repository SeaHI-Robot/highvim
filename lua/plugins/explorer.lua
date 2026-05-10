which_explorer = "neo-tree"
-- which_explorer = "nvim-tree"

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{
				"<C-e>",
				function()
					require("neo-tree.command").execute({ toggle = true, reveal = true })
				end,
				desc = "Toggle NeoTree",
				mode = { "n" },
			},
			{ "<C-b>", "<cmd>Neotree close<CR>", desc = "Close NeoTree", mode = { "n" } },
			{ "<leader>ge", "<cmd>Neotree git_status left<CR>", desc = "Git Explorer" },
			{ "<leader>be", "<cmd>Neotree buffers float<CR>", desc = "Buffer Explorer" },
		},
		init = function()
			-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
			-- because `cwd` is not set up properly.
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		opts = {
			source_selector = {
				winbar = true,
				separator = "|",
				content_layout = "center",
				-- truncation_character = "",
				sources = {
					{ source = "filesystem", display_name = "󱉭 Files" },
					{ source = "git_status", display_name = "󰊢 Git" },
					-- { source = "buffers", display_name = " Buffers" },
				},
			},
			enable_diagnostics = false,
			close_if_last_window = true,
			use_default_mappings = false,
			popup_border_style = "rounded", -- no support "none"
			default_component_configs = {
				icon = {
					folder_closed = "󰉋",
					folder_open = "󰝰",
					folder_empty = "󰉖",
					folder_empty_open = "󰷏",
					default = "󰡯",
				},
				modified = { symbol = " " },
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				name = {
					trailing_slash = false,
					highlight_opened_files = true,
					use_git_status_colors = true,
				},
				git_status = {
					symbols = {
						added = "󰐖 ", -- 
						modified = "●", --  󱗜
						deleted = "󰍵 ", --   ✖
						renamed = "󰁕 ", --  󰜵
						ignored = "󰿠 ", -- 

						untracked = " ", --   󰩳
						unstaged = "󰄱 ", --  󰄱 󰙀 󰔌 󰆟
						staged = "󰱒 ", --  
						conflict = " ", --  
					},
				},
			},
			commands = { -- Custom commands: "open_but_focus", "system_open", "navigate_up_and_close", "copy_selector"
				open_but_focus = function(state)
					state.commands["open"](state)
					vim.cmd("Neotree focus")
				end,
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.cmd(string.format("silent !open '%s'", path))
				end,
				smart_l_key = function(state)
					local preview = require("neo-tree.sources.common.preview")
					if preview.is_active() then
						preview.focus()
					else
						state.commands["open"](state)
					end
				end,
				navigate_up_and_close = function(state)
					local fs = require("neo-tree.sources.filesystem")
					local utils = require("neo-tree.utils")
					local parent_path, _ = utils.split_path(state.path)
					if not utils.truthy(parent_path) then
						return
					end
					local path_to_reveal = nil
					local node = state.tree:get_node()
					if node then
						path_to_reveal = node:get_id()
					end
					if state.search_pattern then
						fs.reset_search(state, false)
					end
					fs._navigate_internal(state, parent_path, path_to_reveal, function()
						require("neo-tree.sources.common.commands").close_node(state)
					end, false)
				end,
				copy_selector = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local vals = {
						["FileName"] = filename,
						["BaseName"] = modify(filename, ":r"),
						["FileType"] = modify(filename, ":e"),
						["Path (CWD)"] = modify(filepath, ":."),
						["Path (Global)"] = filepath,
						["Path (HOME)"] = modify(filepath, ":~"),
						["URI"] = vim.uri_from_fname(filepath),
					}
					local options = vim.tbl_filter(function(val)
						return vals[val] ~= ""
					end, vim.tbl_keys(vals))
					if vim.tbl_isempty(options) then
						vim.notify("No values to copy", vim.log.levels.WARN)
						return
					end
					table.sort(options)
					vim.ui.select(options, {
						prompt = "Choose to copy to clipboard:",
						format_item = function(item)
							return ("%s: %s"):format(item, vals[item])
						end,
					}, function(choice)
						local result = vals[choice]
						if result then
							vim.notify(("Copied: `%s`"):format(result))
							vim.fn.setreg("+", result)
						end
					end)
				end,
			},
			window = {
				position = "left",
				width = function()
					local width = vim.o.columns * 0.2
					width = math.max(width, 25)
					width = math.min(width, 35)
					return math.floor(width)
				end,
				mappings = {
					["o"] = "open",
					["<CR>"] = "open",
					["<Esc>"] = "cancel",

					["\\"] = "open_vsplit",
					["-"] = "open_split",

					["R"] = "refresh",
					["a"] = { "add", config = { show_path = "relative", insert_as = "sibling" } },
					["A"] = { "add", config = { show_path = "relative", insert_as = "child" } },
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",

					["["] = "prev_source",
					["]"] = "next_source",
					["<A-h>"] = "prev_source",
					["<A-l>"] = "next_source",

					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",

					["<C-d>"] = { "scroll_preview", config = { direction = -4 } },
					["<C-u>"] = { "scroll_preview", config = { direction = 4 } },

					["q"] = "close_window",
					["?"] = "show_help",

					["P"] = { "toggle_preview", config = { use_float = true } },
				},
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.opt_local.scrolloff = 0
						vim.opt_local.sidescrolloff = 0
						-- vim.opt.cursorline = true
					end,
				},
			},
			-- ==========  File Explorer Settings  ==========
			filesystem = {
				bind_to_cwd = false,
				hijack_netrw_behavior = "disabled",
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					show_hidden_count = false,
					never_show = {
						".DS_Store",
						"__pycache__",
					},
				},
				window = {
					mappings = {
						["O"] = {
							"show_help",
							nowait = false,
							config = { title = "Order by", prefix_key = "O" },
						},
						["Oc"] = { "order_by_created", nowait = false },
						["Od"] = { "order_by_diagnostics", nowait = false },
						["Og"] = { "order_by_git_status", nowait = false },
						["Om"] = { "order_by_modified", nowait = false },
						["On"] = { "order_by_name", nowait = false },
						["Os"] = { "order_by_size", nowait = false },
						["Ot"] = { "order_by_type", nowait = false },

						["."] = "toggle_hidden",
						-- ["<C-h>"] = "toggle_hidden",

						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["#"] = "fuzzy_sorter",

						["h"] = "navigate_up",
						["L"] = "set_root",

						["gp"] = "prev_git_modified",
						["gn"] = "next_git_modified",

						-- copy filename [custom command]
						["Y"] = "copy_selector",
						["c"] = "copy_selector",
						["<TAB>"] = "open_but_focus",
						["<C-o>"] = "system_open",
						["<BS>"] = "navigate_up_and_close",
						["l"] = "smart_l_key",
					},
					fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
						["<down>"] = "move_cursor_down",
						["<C-j>"] = "move_cursor_down",
						["<TAB>"] = "move_cursor_down",
						["<up>"] = "move_cursor_up",
						["<C-k>"] = "move_cursor_up",
						["<S-Tab>"] = "move_cursor_up",
						["<esc>"] = "close",
					},
				},
				use_libuv_file_watcher = true,
				follow_current_file = { enabled = true },
			},
			-- ==========  Buffer Explorer Settings  ==========
			buffers = {
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--              -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				group_empty_dirs = true, -- when true, empty folders will be grouped together
				show_unloaded = true,
				window = {
					mappings = {
						["d"] = "buffer_delete",
						["bd"] = "buffer_delete",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["o"] = {
							"show_help",
							nowait = false,
							config = { title = "Order by", prefix_key = "o" },
						},
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
			git_status = {
				window = {
					position = "float",
					mappings = {
						["O"] = {
							"show_help",
							nowait = false,
							config = { title = "Order by", prefix_key = "o" },
						},
						["Oc"] = { "order_by_created", nowait = false },
						["Od"] = { "order_by_diagnostics", nowait = false },
						["Om"] = { "order_by_modified", nowait = false },
						["On"] = { "order_by_name", nowait = false },
						["Os"] = { "order_by_size", nowait = false },
						["Ot"] = { "order_by_type", nowait = false },

						["A"] = "git_add_all",

						["g"] = {
							"show_help",
							nowait = true,
							config = { title = "Git commands", prefix_key = "g" },
						},
						["gu"] = { "git_unstage_file" },
						["gU"] = { "git_undo_last_commit" },
						["ga"] = { "git_add_file" },
						["gr"] = { "git_revert_file" },
						["gc"] = { "git_commit" },
						["gp"] = { "git_push" },
						["gg"] = { "git_commit_and_push" },
					},
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)

			-- Rename file function integration with Snacks.nvim
			local function on_move(data)
				Snacks.rename.on_rename_file(data.source, data.destination)
			end
			local events = require("neo-tree.events")
			opts.event_handlers = opts.event_handlers or {}
			vim.list_extend(opts.event_handlers, {
				{ event = events.FILE_MOVED, handler = on_move },
				{ event = events.FILE_RENAMED, handler = on_move },
			})

			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
		cond = function()
			if which_explorer == "neo-tree" then
				return true
			end
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeFocus" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<C-e>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree", mode = { "n" } },
			{ "<C-b>", "<cmd>NvimTreeClose<CR>", desc = "Close NvimTree", mode = { "n" } },
		},
		config = function()
			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Parent Dir"))
				vim.keymap.set("n", "L", api.tree.change_root_to_node, opts("CD"))
				vim.keymap.set("n", "<C-h>", api.tree.toggle_hidden_filter, opts("Toggle Hidden Filter"))
				vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, opts("Toggle Hidden Filter"))
				vim.keymap.set("n", "<C-\\>", api.node.run.cmd, opts("Run Command"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
				vim.keymap.set("n", "<C-e>", api.tree.close, opts("Close nvim-tree"))
				vim.keymap.set("n", "l", api.node.open.preview, opts("Open Preview"))
				vim.keymap.set("n", "/", api.live_filter.start, opts("Live Filter"))
				vim.keymap.set("n", "<esc>", api.live_filter.clear, opts("Live Filter"))
				vim.keymap.set("n", "<C-c>", api.tree.collapse_all, opts("Collapse"))
				vim.keymap.set("n", "z", api.tree.collapse_all, opts("Collapse All"))
				vim.keymap.set("n", "Z", api.tree.expand_all, opts("Expand All"))
				vim.keymap.set("n", "|", api.node.open.horizontal, opts("Open: Vertical Split"))
				vim.keymap.set("n", "-", api.node.open.vertical, opts("Open: Horizontal Split"))
				vim.keymap.set("n", "<localleader>r", function()
					local node_under_cursor = api.tree.get_node_under_cursor()
					api.tree.change_root_to_node(node_under_cursor)
				end, opts("Change Root"))
			end

			-- pass to setup along with your other options
			require("nvim-tree").setup({
				on_attach = my_on_attach,
				view = {
					width = function()
						local width = vim.o.columns * 0.2
						width = math.max(width, 25)
						width = math.min(width, 35)
						return math.floor(width)
					end,
					-- relativenumber = true,
					relativenumber = false,
					side = "left",
					number = false,
					float = {
						enable = false, -- set to "true" to enable floating nvim-tree
						open_win_config = function()
							local screen_w = vim.opt.columns:get()
							local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
							local window_w = screen_w * 0.16
							local window_h = screen_h
							local window_w_int = math.floor(window_w)
							local window_h_int = math.floor(window_h)
							-- local center_x = (screen_w - window_w) / 2
							-- local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
							local center_x = 0
							local center_y = 0
							return {
								border = "rounded",
								relative = "editor",
								row = center_y,
								col = center_x,
								width = window_w_int,
								height = window_h_int,
							}
						end,
					},
				},
				renderer = {
					icons = {
						git_placement = "after",
						symlink_arrow = " 󰁕 ",
						show = {
							hidden = true,
						},
						glyphs = {
							-- default = "󱓻",
							symlink = "",
							bookmark = "",
							-- modified = "",
							hidden = "󰊠",
							-- folder = {
							--     arrow_closed = " ",
							--     arrow_open = " ",
							--     default = "",
							--     open = "",
							--     empty = "",
							--     empty_open = "",
							--     symlink = "",
							--     symlink_open = "",
							-- },
							-- git = {
							--     unmerged = "",
							--     untracked = "󰫢",
							--     renamed = "",
							--     deleted = "",
							--     ignored = "",
							-- },
						},
					},
				},
				filters = {
					dotfiles = false,
				},
				respect_buf_cwd = true,
				update_cwd = true,
				disable_netrw = true,
				hijack_netrw = true,
				hijack_cursor = true,
				sync_root_with_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
			})
			-- diable signcolumn in NvimTree
			require("nvim-tree.view").View.winopts.signcolumn = "no"

			-- Rename file function integration with Snacks.nvim
			local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
			vim.api.nvim_create_autocmd("User", {
				pattern = "NvimTreeSetup",
				callback = function()
					local events = require("nvim-tree.api").events
					events.subscribe(events.Event.NodeRenamed, function(data)
						if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
							data = data
							Snacks.rename.on_rename_file(data.old_name, data.new_name)
						end
					end)
				end,
			})
		end,
		cond = function()
			if which_explorer == "nvim-tree" then
				return true
			end
		end,
	},
}
