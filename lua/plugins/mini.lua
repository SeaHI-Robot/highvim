-- this config contains the configuration for the Mini plugin suite
-- including `mini.files` and `mini.ai` for now

return {
	{
		"echasnovski/mini.files",
		version = "*",
		opts = {
			windows = {
				preview = true,
				width_focus = 30,
				width_preview = 60,
			},
			options = {
				-- Whether to use for editing directories
				-- Disabled by default in LazyVim because neo-tree is used for that
				use_as_default_explorer = false,
			},
			mappings = {
				synchronize = "<C-s>",
				show_help = "?",
				go_in_horizontal_plus = "-",
				go_in_vertical_plus = "\\",
				toggle_hiden = ".",
			},
		},
		keys = {
			{
				"<localleader>m",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
				end,
				desc = "Open mini.files (Current File Directory)",
			},
			{
				"<localleader>M",
				function()
					require("mini.files").open(vim.uv.cwd(), true)
				end,
				desc = "Open mini.files (Current Working Directory)",
			},
		},
		config = function(_, opts)
			-- relink hilight group
			vim.api.nvim_set_hl(0, "MiniFilesNormal", { link = "Normal" })

			require("mini.files").setup(opts)

			local show_dotfiles = true
			local filter_show = function(fs_entry)
				return true
			end
			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				require("mini.files").refresh({
					content = {
						filter = new_filter,
					},
				})
			end

			local map_split = function(buf_id, lhs, direction, close_on_file)
				local rhs = function()
					local new_target_window
					local cur_target_window = require("mini.files").get_explorer_state().target_window
					if cur_target_window ~= nil then
						vim.api.nvim_win_call(cur_target_window, function()
							vim.cmd("belowright " .. direction .. " split")
							new_target_window = vim.api.nvim_get_current_win()
						end)

						require("mini.files").set_target_window(new_target_window)
						require("mini.files").go_in({ close_on_file = close_on_file })
					end
				end

				local desc = "Open in " .. direction .. " split"
				if close_on_file then
					desc = desc .. " and close"
				end
				vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id

					vim.keymap.set(
						"n",
						"<C-h>" or opts.mappings and opts.mappings.toggle_hidden or "g.",
						toggle_dotfiles,
						{
							buffer = buf_id,
							desc = "Toggle hidden files",
						}
					)
					vim.keymap.set("n", "o", function()
						require("mini.files").go_in()
						require("mini.files").close()
					end, {
						buffer = buf_id,
						desc = "Go in entry, Close",
					})
					vim.keymap.set("n", "<CR>", function()
						require("mini.files").go_in()
						require("mini.files").close()
					end, {
						buffer = buf_id,
						desc = "Go in entry, Close",
					})
					vim.keymap.set("n", "<Tab>", function()
						require("mini.files").go_in()
					end, {
						buffer = buf_id,
						desc = "Go in entry",
					})
					vim.keymap.set("n", "<Esc>", function()
						require("mini.files").close()
					end, {
						buffer = buf_id,
						desc = "Close",
					})

					map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
					map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
					map_split(
						buf_id,
						opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S",
						"horizontal",
						true
					)
					map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
				end,
			})

			-- Rename file function integration with Snacks.nvim
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesActionRename",
				callback = function(event)
					Snacks.rename.on_rename_file(event.data.from, event.data.to)
				end,
			})
		end,
	},
	{

		"echasnovski/mini.ai",
		version = "*",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- no need to load the plugin, since we only need its queries
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				mappings = {
					-- Main textobject prefixes
					around = "a",
					inside = "i",
					around_next = "an",
					inside_next = "in",
					around_last = "al",
					inside_last = "il",
					-- Move cursor to corresponding edge of `a` textobject
					goto_left = "g[",
					goto_right = "g]",
				},
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	},
}
