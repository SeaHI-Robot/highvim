return { -- Session management. This saves your session in the background,
	-- keeping track of open buffers, window arrangement, and more.
	-- You can restore sessions when returning through the dashboard.
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		-- stylua: ignore
		-- keys = {
		--   { "<localleader>Sr", function() require("persistence").load() end, desc = "Restore Session" },
		--   { "<localleader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
		--   { "<localleader>Sd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
		-- },
	}, -- library used by other plugins
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
}
