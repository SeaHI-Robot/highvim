return {
	{
		"petertriho/nvim-scrollbar",
		cmd = "ScrollbarToggle",
		event = "VeryLazy",
		opts = {
			handelers = {
				gitsigns = true, -- Requires gitsigns
				search = true, -- Requires hlslens
			},
			marks = {
				Search = {
					color = "#CBA6F7",
				},
				GitAdd = { text = "┃" },
				GitChange = { text = "┃" },
				GitDelete = { text = "_" },
			},
			excluded_filetypes = {
				"snacks_picker_input",
				"snacks_picker_list",
				"snacks_notif",
				"llm",
				"blink-cmp-menu",
				"dropbar_menu",
				"dropbar_menu_fzf",
				"DressingInput",
				"cmp_docs",
				"cmp_menu",
				"noice",
				"prompt",
				"TelescopePrompt",
				"TelescopeResults",
				"NvimTree",
				"neo-tree",
				"minifiles",
			},
			excluded_buftypes = {
				"terminal",
				"prompt",
				"noice",
			},
			handlers = {
				cursor = false,
			},
		},
	},
}
