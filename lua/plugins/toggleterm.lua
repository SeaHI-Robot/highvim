return {
	-- amongst your other plugins
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = "ToggleTerm",
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 5
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.3
			end
		end,
	},
	keys = {
		{
			"<C-\\>",
			"<cmd>ToggleTerm<CR>",
			desc = "Terminal: horizontal",
			mode = { "n", "t" },
		},
		{
			"<C-space>",
			"<cmd>ToggleTerm<CR>",
			desc = "Terminal: horizontal",
			mode = { "n", "t" },
		},
		{
			"<localleader>f<space>",
			'<cmd>ToggleTerm direction="float"<CR>',
			desc = "Terminal: float",
			mode = { "n", "t" },
		},
	},
}
