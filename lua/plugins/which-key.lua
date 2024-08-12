return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	-- set icon mappings to true if you have a Nerd Font
	mappings = vim.g.have_nerd_font,
	-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
	-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
	keys = {
		{
			"<localleader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Toggle Which Key Help",
			mode = "n",
		},
		{
			"<localleader>wk",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Toggle Which Key Help",
			mode = "n",
		},
		{
			"gn",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "<localleader>gn", bang = true })
				else
					vim.cmd("Gitsigns next_hunk")
				end
			end,
			desc = "Git Next Hunk",
			mode = { "n", "v" },
		},
		{
			"gN",
			function()
				vim.cmd("Gitsigns prev_hunk")
			end,
			desc = "Git Previous Hunk",
			mode = { "n", "v" },
		},
		{
			"gp",
			function()
				vim.cmd("Gitsigns preview_hunk_inline")
			end,
			desc = "Git Preview Hunk Inline",
			mode = { "n", "v" },
		},
		{
			"gP",
			function()
				vim.cmd("Gitsigns preview_hunk")
			end,
			desc = "Git Preview Hunk",
			mode = { "n", "v" },
		},
		{
			"<localleader>gb",
			function()
				-- vim.cmd("Gitsigns toggle_current_line_blame")
				vim.cmd("Gitsigns blame_line")
			end,
			desc = "Git Blame Line",
		},
		{
			"<localleader>gr",
			function()
				vim.cmd("Gitsigns reset_hunk")
			end,
			desc = "Git Reset Hunk",
			mode = { "n", "v" },
		},
		{
			"<localleader>gR",
			function()
				vim.cmd("Gitsigns reset_buffer")
			end,
			desc = "Git Reset Buffer",
			mode = { "n", "v" },
		},
		{
			"<localleader>gd",
			function()
				vim.cmd("Gitsigns toggle_deleted")
			end,
			desc = "Git Toggle Deleted",
			mode = { "n", "v" },
		},
		{
			"<localleader>gD",
			function()
				vim.cmd("Gitsigns diffthis vertical=1")
			end,
			desc = "Git Diff This File",
			mode = { "n", "v" },
		},
		{
			"<localleader>gL",
			function()
				vim.cmd("Gitsigns diffthis vertical=1 ~1")
			end,
			desc = "Git Diff This File (Last Commit)",
			mode = { "n", "v" },
		},
		{
			"<localleader>gh",
			function()
				vim.cmd("Gitsigns select_hunk")
			end,
			desc = "Git Select Hunk",
			mode = { "n", "v" },
		},
		{
			"<localleader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Git Lazygit",
			mode = { "n", "v" },
		},
		{ "<localleader>lz", "<cmd>Lazy<CR>", desc = "Toggle Lazy.Nvim Panel", mode = "n" },
	},
	opts = {
		preset = "helix",
		layout = {
			width = { min = 50 },
		},
		win = {
			width = { min = 50, max = 100 },
			height = { min = 4, max = 0.6 },
			padding = { 0, 1 },
			border = "rounded",
			col = -1,
			row = -1,
			title = true,
			title_pos = "left",
		},
		-- Specifically Added Keys
		spec = {
			-- Substitution Keybindings defined in `core/keymaps.lua`
			{ "<localleader>s", icon = { icon = "󰑕", color = "cyan" } },
			{ "<localleader>S", icon = { icon = "󰑕", color = "cyan" } },
			-- Format code
			{ "<localleader>F" },
			-- rename: lspsaga
			{ "<localleader>rn", icon = "󰑕" },
			-- python: conda
			-- { "<localleader>C", icon = { icon = "", color = "yellow" } },
			-- avante
			-- { "<localleader>a", icon = { icon = "󱜙", color = "orange" }, desc = "Avante" },
			-- latex: vimtex
			{ "<localleader>lc", icon = { icon = "", color = "grey" } },
			{ "<localleader>lC", icon = { icon = "", color = "grey" } },
			{ "<localleader>li", icon = { icon = "", color = "grey" } },
			{ "<localleader>lv", icon = { icon = "", color = "grey" } },
			-- print
			{ "<localleader>p", desc = "Print", icon = { icon = "", color = "grey" } },
			-- ROS
			-- { "<localleader>R", icon = { icon = "󱚣", color = "cyan" } },
			-- Quarto
			{ "<localleader>Q", icon = { icon = "󱚣", color = "cyan" } },
			-- Command Line
			{ "<localleader>;", icon = { icon = "", color = "blue" } },
			-- g key
			{ "gg", icon = "", desc = "First line" },
			{ "ge", icon = "", desc = "Prev end of word" },
			{ "gu", icon = "󰬴", desc = "Lowercase" },
			{ "gU", icon = "󰬴", desc = "Uppercase" },
			{ "gv", icon = "󰒅", desc = "Last visual selection" },
			{ "g[", icon = "󰅪", desc = 'Move to left "around"' },
			{ "g]", icon = "󰅪", desc = 'Move to right "around"' },
			-- c key
			{ "<localleader>c", desc = "Code & Change & Comment" },
			-- d key
			{ "<localleader>d", icon = { icon = "", color = "grey" }, desc = "Diagonostic & Document & Dismiss" },
			-- G key: Github Copilot
			{ "<localleader>G", icon = { icon = "", color = "grey" }, desc = "Github Copilot" },
			{ "<localleader>Gd", icon = { icon = "", color = "grey" }, desc = "Github Copilot: Disable" },
			{ "<localleader>Ge", icon = { icon = "", color = "grey" }, desc = "Github Copilot: Enable" },
			{ "<localleader>Gp", icon = { icon = "", color = "grey" }, desc = "Github Copilot: Panel" },
			{ "<localleader>Gs", icon = { icon = "", color = "grey" }, desc = "Github Copilot: Status" },
			{
				"<localleader>Gt",
				icon = { icon = "", color = "grey" },
				desc = "Github Copilot: Suggestion Toggle Auto Trigger",
			},
			-- h key
			{ "<localleader>h", icon = { icon = "󰫵", color = "grey" }, desc = "Hide & Hardtime" },
			-- l key
			{ "<localleader>l", icon = { icon = "󰫹", color = "grey" } },
			-- t key: LLM translator
			{ "<localleader>t", icon = { icon = "󰗊", color = "orange" }, desc = "Translator" },
			-- buffer
			{ "<localleader>b", desc = "Buffer" },
			-- telescope
			{ "<localleader>f", desc = "Find" },
			-- git
			{ "<localleader>g", desc = "Git" },
			-- ui
			{ "<localleader>u", desc = "UI" },
			{ "<localleader>ug", desc = "Git" },
			-- notification
			{ "<localleader>n", desc = "Notification" },
			-- zen mode
			{ "<localleader>z", desc = "Zen Mode" },
			-- [ and ]
			{ "]i", icon = { icon = "", color = "orange" }, desc = "Jump to End of Scope" },
			{ "[i", icon = { icon = "", color = "orange" }, desc = "Jump to Start of Scope" },
			{ "[m", icon = { icon = "", color = "orange" }, desc = "Previous Method Start" },
			{ "[M", icon = { icon = "", color = "orange" }, desc = "Previous Method End" },
			{ "]m", icon = { icon = "", color = "orange" }, desc = "Next Method Start" },
			{ "]M", icon = { icon = "", color = "orange" }, desc = "Next Method End" },
			{ "[%", icon = { icon = "", color = "orange" }, desc = "Previous Unmatched Group" },
			{ "]%", icon = { icon = "", color = "orange" }, desc = "Next Unmatched Group" },
			{ "[{", icon = { icon = "", color = "orange" }, desc = "Previous {" },
			{ "]{", icon = { icon = "", color = "orange" }, desc = "Next {" },
			{ "[(", icon = { icon = "", color = "orange" }, desc = "Previous (" },
			{ "](", icon = { icon = "", color = "orange" }, desc = "Next (" },
			{ "[<", icon = { icon = "", color = "orange" }, desc = "Previous <" },
			{ "]<", icon = { icon = "", color = "orange" }, desc = "Next <" },
			{ "[s", icon = { icon = "", color = "red" }, desc = "Previous Misspelled Word" },
			{ "]s", icon = { icon = "", color = "red" }, desc = "Next Misspelled Word" },
			{ "[c", icon = { icon = "", color = "yellow" }, desc = "Previous Misspelled Word" },
			{ "]c", icon = { icon = "", color = "yellow" }, desc = "Next Misspelled Word" },
			{ "[d", icon = { icon = "", color = "yellow" }, desc = "Previous Diagonostic" },
			{ "]d", icon = { icon = "", color = "yellow" }, desc = "Next Diagonostic" },
			{ "[D", icon = { icon = "", color = "yellow" }, desc = "Fisrt Diagonostic" },
			{ "]D", icon = { icon = "", color = "yellow" }, desc = "Last Diagonostic" },
			{ "[D", icon = { icon = "", color = "yellow" }, desc = "Fisrt Diagonostic" },
			{ "]D", icon = { icon = "", color = "yellow" }, desc = "Last Diagonostic" },
			{ "[t", icon = { icon = "", color = "cyan" }, desc = "Previous Tag" },
			{ "]t", icon = { icon = "", color = "cyan" }, desc = "Next Tag" },
			{ "[T", icon = { icon = "", color = "cyan" }, desc = "First Tag" },
			{ "]T", icon = { icon = "", color = "cyan" }, desc = "Last Tag" },
			{ "[_", icon = { icon = "󱁐", color = "cyan" } },
			{ "]_", icon = { icon = "󱁐", color = "cyan" } },
			-- folding
			{ "zr", icon = { icon = "", color = "orange" } },
			{ "zR", icon = { icon = "", color = "orange" } },
			{ "zm", icon = { icon = "", color = "orange" } },
			{ "zM", icon = { icon = "", color = "orange" } },
			-- { "zf", icon = { icon = "", color = "orange" } },
			{ "zj", icon = { icon = "", color = "orange" } },
			{ "zk", icon = { icon = "", color = "orange" } },
			{ "zK", icon = { icon = "", color = "orange" } },
			{ "zL", icon = { icon = "", color = "orange" }, desc = "Half screen to the right" },
			{ "zH", icon = { icon = "", color = "orange" }, desc = "Half screen to the left" },
		},
	},
}
