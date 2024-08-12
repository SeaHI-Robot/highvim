return {
	"hedyhli/outline.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<localleader>o",
			"<cmd>Outline<CR>",
			desc = "Toggle Outline for this buffer",
			mode = { "n" },
		},
	},
	config = function()
		require("outline").setup({
			-- Your setup opts here (leave empty to use defaults)
		})
	end,
}
