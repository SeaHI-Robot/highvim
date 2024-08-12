return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	opts = {
		signcolumn = true,
		numhl = false,
		-- word_diff = true,
		linehl = false,
		current_line_blame = false, -- show blame on the current line
		attach_to_untracked = true,
		preview_config = {
			border = "rounded",
		},
	},
	-- The keybindings of gitsigns are placed into which-key.lua
	config = function(_, opts)
		require("gitsigns").setup(opts)
		-- Show git changes in the scrollbar
		-- require("scrollbar.handlers.gitsigns").setup()
	end,
}
