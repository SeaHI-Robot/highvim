-- plugins/quarto.lua
return {
	"quarto-dev/quarto-nvim",
	dependencies = {
		"jmbuhr/otter.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = { "QuartoPreview", "QuartoPreviewNoWatch", "QuartoUpdatePreview", "QuartoClosePreview", "QuartoActivate" },
	ft = { "quarto" },
	opts = {
		debug = false,
		closePreviewOnExit = true,
		lspFeatures = {
			enabled = true,
			chunks = "curly",
			languages = { "python", "bash", "html" },
			diagnostics = {
				enabled = true,
				triggers = { "BufWritePost" },
			},
			completion = {
				enabled = true,
			},
		},
		codeRunner = {
			enabled = true,
			default_method = "slime", -- "molten", "slime", "iron" or <function>
			ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
			-- Takes precedence over `default_method`
			never_run = { "yaml" }, -- filetypes which are never sent to a code runner
		},
	},
	keys = {
		{
			"<localleader>Q",
			"<cmd>QuartoPreview<cr>",
			desc = "Quarto Preview",
			mode = { "n" },
		},
	},
}
