return {

	-- Github Copilot, Not Pure Lua!
	-- {
	--     "github/copilot.vim",
	--     event = "VeryLazy",
	--     opts = {},
	--     keys = {
	--         { "<localleader>Ge", "<cmd>Copilot enable<CR>",  desc = "[G]ithub Copilot [E]nable" },
	--         { "<localleader>Gs", "<cmd>Copilot status<CR>",  desc = "[G]ithub Copilot [S]tatus" },
	--         { "<localleader>Gd", "<cmd>Copilot disable<CR>", desc = "[G]ithub Copilot [D]isable" },
	--         { "<localleader>Gp", "<cmd>Copilot panel<CR>",   desc = "[G]ithub Copilot [P]anel" },
	--     },
	--     config = function()
	--         vim.keymap.set('i', '<C-_>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, silent = true })  -- Github Copilot
	--     end
	-- },
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "VeryLazy",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-\\>",
					next = "<M-]>",
					prev = "<M-[>",

					dismiss = "<C-E>",
				},
			},
			panel = { enabled = true },
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			-- Setting workspace_folder helps Copilot to understand the context of your code better.
			workspace_folders = {
				"/home/syw/.gitrepos/ConstrainRL-Demo/",
				-- "/home/syw/projects",
			},
		},
		keys = {
			-- {
			--     "<C-_>",
			--     function()
			--         require("copilot.suggestion").accept()
			--     end,
			--     desc = "Github Copilot: Accept Suggestion",
			--     mode = "i",
			-- },
			{
				"<localleader>Ge",
				"<cmd>Copilot enable<CR> <cmd>Copilot status<CR>",
				desc = "Github Copilot: Enable",
				mode = "n",
			},
			{
				"<localleader>Gs",
				"<cmd>Copilot status<CR>",
				desc = "Github Copilot: Status",
				mode = "n",
			},
			{
				"<localleader>Gd",
				"<cmd>Copilot disable<CR> <cmd>Copilot status<CR>",
				desc = "Github Copilot: Disable",
				mode = "n",
			},
			{
				"<localleader>Gp",
				"<cmd>Copilot panel<CR>",
				desc = "Github Copilot: Panel",
				mode = "n",
			},
			{
				"<localleader>Gt",
				"<cmd>Copilot suggestion toggle_auto_trigger<CR>",
				desc = "Github Copilot: Suggestion Toggle Auto Trigger",
				mode = "n",
			},
			{
				"<Tab>",
				function()
					if require("copilot.suggestion").is_visible() then
						require("copilot.suggestion").accept()
					else
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
					end
				end,
				desc = "Super Tab for Copilot",
				mode = "i",
			},
		},
	},
}
