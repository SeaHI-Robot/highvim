return {
	"mikavilpas/yazi.nvim",
	cmd = "Yazi",
	keys = {
		{
			"<localleader>y",
			"<cmd>Yazi<cr>",
			desc = "[Yazi] Open Current File Directory",
		},
		-- {
		--     "<localleader>cwd",
		--     "<cmd>Yazi cwd<cr>",
		--     desc = "[Yazi] Open Current Working Directory",
		-- },
		-- {
		--     "<localleader>y",
		--     "<cmd>Yazi toggle<cr>",
		--     desc = "[Yazi] Resume Last Yazi Session",
		-- },
	},
	opts = {
		-- if you want to open yazi instead of netrw, see below for more info
		open_for_directories = true,
		keymaps = {
			show_help = "?",
			open_file_in_vertical_split = "\\",
			open_file_in_horizontal_split = "-",
		},
	},
	-- 👇 if you use `open_for_directories=true`, this is recommended
	init = function()
		-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
		-- vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
}
