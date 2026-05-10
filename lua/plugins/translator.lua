-- local which_translator = "vim-translator"
local which_translator = "Trans.nvim"

return {
	{
		"voldikss/vim-translator",
		keys = {
			{ "<C-t>", "<cmd>TranslateW<CR>", desc = "Translate English to Chinese", mode = { "n" } },
			{ "<C-t>", ":Translate<CR>", desc = "Translate English to Chinese", mode = { "v" }, silent = true },
		},
		config = function()
			vim.g.translator_default_engines = { "google" }
			-- ['bing', 'google', 'haici', 'youdao'] youdao not work well
			vim.api.nvim_set_hl(0, "TranslatorBorder", { link = "Normal" })
			vim.g.translator_window_borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
		end,
		cond = function()
			if which_translator == "vim-translator" then
				return true
			end
		end,
	},
	{
		"syw-robotics/Trans.nvim",
		build = function()
			require("Trans").install()
		end,
		keys = {
			{ "<C-t>", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = "󰊿 Translate" },
			-- { '<C-p>', mode = { 'n', 'x' }, '<Cmd>TransPlay<CR>', desc = ' Auto Play' }, -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
			{ "<C-p>", "<Cmd>TranslateInput<CR>", desc = "󰊿 Translate From Input" },
		},
		dependencies = { "kkharji/sqlite.lua" },
		opts = {
			dir = os.getenv("HOME") .. "/.config/nvim/dict",
			-- theme = "tokyonight",
			theme = "catppuccin",
			frontend = {
				default = {
					auto_play = false,
					title = { { " 󰊿 Trans ", "TransTitle" } },
					animation = {
						open = "slid", -- 'fold', 'slid'
						close = "slid",
						interval = 2,
					},
				},
				hover = {
					width = 60,
					height = 30,
					keymaps = {
						pageup = "<C-u>",
						pagedown = "<C-d>",
						pin = "p",
						close = "q",
						toggle_entry = "<leader>;",
					},
					order = {
						offline = {
							-- 'title',
							-- 'tag',
							"translation",
							"definition",
							-- 'pos',
							-- 'exchange',
						},
					},
				},
			},
		},
		cond = function()
			if which_translator == "Trans.nvim" then
				return true
			end
		end,
	},
}
