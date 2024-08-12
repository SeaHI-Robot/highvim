local which_colorscheme = "catppuccin-frappe" -- all catppuccin themes are available, recommend to use frappe
-- local which_colorscheme = "nordfox" -- all nightfox themes are available, recommend to use nordfox

-- Now, only catppuccin-frappe supports this option.
-- TelescopeBordless = true -- true: Telescope without border
TelescopeBordless = false -- false: Telescope with border;

return {
	{
		"shaunsingh/nord.nvim",
		lazy = true,
		priority = 100,
		-- config = function()
		--     -- setup must be called before loading
		-- vim.cmd([[colorscheme nord]])
		-- end
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 700,
		opts = { style = "moon" },
		config = function()
			-- setup must be called before loading
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"sainnhe/everforest",
		lazy = true,
		-- lazy = false,
		priority = 800,
		config = function()
			vim.g.everforest_enable_italic = true
			vim.g.everforest_background = "soft" -- 'soft' 'medium' 'hard'
			vim.g.everforest_transparent_background = 2 -- Disable setting background
			vim.g.everforest_better_performance = 1
			vim.cmd.colorscheme("everforest")
		end,
	},
	-- -- neanias/everforest is a lua port for everforest in neovim, but transparent_background doesn't work in kitty
	-- {
	--     'neanias/everforest',
	--     lazy = true,
	--     -- lazy = false,
	--     priority = 800,
	--     opts = {
	--         background = 'soft', -- Options are "soft", "medium" or "hard".
	--         diagnostic_virtual_text = 'colored',
	--         transparent_background_level = 1,
	--         disable_terminal_colors = true,
	--         italics = true,
	--         ui_contrast = 'low',
	--         dim_inactive_windows = false,
	--         inlay_hints_background = "none", -- "dimmed" or "none"
	--         on_highlights = function(hl, palette)
	--             hl.NormalFloat = { fg = palette.fg, bg = palette.none }
	--         end
	--     },
	--     config = function()
	--         vim.cmd.colorscheme('everforest')
	--     end
	-- },
	{
		"catppuccin/nvim",
		lazy = true,
		-- lazy = false,
		priority = 900,
		init = function()
			-- setup must be called before loading
			if which_colorscheme == "catppuccin-frappe" then
				vim.cmd("colorscheme catppuccin-frappe")
			elseif which_colorscheme == "catppuccin-macchiato" then
				vim.cmd("colorscheme catppuccin-macchiato")
			elseif which_colorscheme == "catppuccin-mocha" then
				vim.cmd("colorscheme catppuccin-mocha")
			elseif which_colorscheme == "catppuccin-latte" then
				vim.cmd("colorscheme catppuccin-latte")
			end
		end,
		config = function()
			require("catppuccin").setup({
				custom_highlights = function(colors)
					local highlights = {
						FoldTag = { fg = colors.yellow, bg = colors.surface1 },
						Pmenu = { bg = colors.base },
						WhichKeyNormal = { bg = colors.base },
						WhichKeyBorder = { bg = colors.base, fg = colors.overlay0 },
						WhichKeyTitle = { bg = colors.base, fg = colors.overlay0 },
						NvimTreeNormal = { bg = colors.base },
						SnacksPicker = { bg = colors.base },
						BlinkCmpMenu = { bg = colors.base },
						BlinkCmpMenuBorder = { bg = colors.base },
						NvimTreeNormalNC = { bg = colors.base },
						NeoTreeNormal = { bg = colors.base },
						NeoTreeNormalNC = { bg = colors.base },
						NeoTreeStatuslineNC = { bg = colors.base },
						NeoTreeStatusline = { bg = colors.base },
						NeoTreeTabInactive = { bg = colors.base, fg = colors.overlay0 },
						NeoTreeTabActive = { bg = colors.base, fg = colors.rosewater },
						NeoTreeTabSeparatorActive = { fg = colors.overlay0, bg = colors.base },
						NeoTreeTabSeparatorInactive = { fg = colors.overlay0, bg = colors.base },
						NeoTreeFloatNormal = { bg = colors.base },
						NormalFloat = { bg = colors.base },
						FloatBorder = { bg = colors.base },
						FloatTitle = { bg = colors.base },
						NeoTreeWinSeparator = { fg = colors.surface0 },
						TelescopePromptTitle = { fg = colors.base, bg = colors.lavender },
						TelescopeResultsTitle = { fg = colors.base, bg = colors.green },
						TelescopeResultsBorder = { fg = colors.base, bg = colors.base },
						TelescopePreviewTitle = { fg = colors.base, bg = colors.maroon },
						TelescopePreviewBorder = { fg = colors.base, bg = colors.base },
						TelescopePromptNormal = { bg = colors.surface0 },
						TelescopePromptBorder = { bg = colors.surface0 },
						TelescopePreviewMatch = { bg = colors.flamingo, fg = colors.base },
						SnacksPickerInput = { bg = colors.surface0 },
						SnacksPickerInputTitle = { fg = colors.base, bg = colors.lavender },
						SnacksPickerInputBorder = { fg = colors.surface0, bg = colors.surface0 },
						SnacksPickerBorder = { fg = colors.base, bg = colors.base },
						SnacksPickerListTitle = { fg = colors.base, bg = colors.green },
						SnacksPickerPreviewTitle = { fg = colors.base, bg = colors.maroon },
						LLMPromptNormal = { bg = colors.surface0 },
						LLMHandlerPromptNormal = { bg = colors.surface0 },
						LLMHandlerPromptBorder = { fg = colors.surface0, bg = colors.surface0 },
						LLMHandlerPreviewNormal = { bg = colors.mantle },
						LLMHandlerPreviewBorder = { fg = colors.base, bg = colors.base },
						SnacksPickerBoxTitle = { fg = colors.base, bg = colors.lavender },
						LlmGrayLight = { bg = colors.base },
					}
					local telescope_bord_highlights = {
						TelescopeResultsNormal = { bg = colors.mantle },
						TelescopeResultsBorder = { fg = colors.mantle, bg = colors.mantle },
						TelescopePreviewNormal = { bg = colors.mantle },
						TelescopePreviewBorder = { fg = colors.mantle, bg = colors.mantle },
						SnacksPickerPreview = { bg = colors.mantle },
						SnacksPickerBorder = { fg = colors.mantle, bg = colors.mantle },
						SnacksPickerList = { bg = colors.mantle },
						LLMDarkNormal = { bg = colors.mantle },
						LlmGrayLight = { bg = colors.mantle },
					}
					if TelescopeBordless == false then
						for key, value in pairs(telescope_bord_highlights) do
							highlights[key] = value
						end
					end
					return highlights
				end,
			})
		end,
        -- stylua: ignore
		opts = {
			-- flavour = catppuccin_flavour, -- latte, frappe, macchiato, mocha
			transparent_background = true,
			background = { light = "latte", dark = "frappe", },
			dim_inactive = { enabled = true }, -- dims the background color of inactive window shade = "dark", percentage = 0.15, -- percentage of the shade to apply to the inactive window ,
			integrations = { cmp = true, blink_cmp = true, flash = true, gitsigns = true, illuminate = true, indent_blankline = { enabled = true }, mason = true, markdown = true, mini = true, neotest = true, neotree = true,
				nvimtree = true, noice = true, notify = true, telescope = true, treesitter = true, treesitter_context = true, which_key = true, rainbow_delimiters = true, -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		},
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		-- lazy = false,
		priority = 1000,
		init = function()
			-- setup must be called before loading
			if which_colorscheme == "nordfox" then
				vim.cmd("colorscheme nordfox")
			elseif which_colorscheme == "dawnfox" then
				vim.cmd("colorscheme dawnfox")
			elseif which_colorscheme == "dayfox" then
				vim.cmd("colorscheme dayfox")
			elseif which_colorscheme == "duskfox" then
				vim.cmd("colorscheme duskfox")
			elseif which_colorscheme == "terafox" then
				vim.cmd("colorscheme terafox")
			elseif which_colorscheme == "carbonfox" then
				vim.cmd("colorscheme carbonfox")
			elseif which_colorscheme == "nightfox" then
				vim.cmd("colorscheme nightfox")
			end
		end,
		config = function(_, opts)
			require("nightfox").setup(opts)
		end,
		opts = function()
			local highlights = {
				all = {
					WhichKeyNormal = { bg = "bg" },
					WhichKeyBorder = { fg = "palette.comment" },
					SnacksPicker = { bg = "bg" },
					NavBuddyNormalFloat = { bg = "bg" },
					BlinkCmpMenu = { bg = "bg" },
					BlinkCmpMenuBorder = { fg = "palette.comment" },
					BlinkCmpLabel = { bg = "bg" },
					BlinkCmpKind = { bg = "bg" },
					BlinkCmpKindText = { bg = "bg", fg = "palette.blue.base" },
					BlinkCmpLabelDescription = { bg = "bg" },
					BlinkCmpDoc = { bg = "bg" },
					BlinkCmpDocBorder = { bg = "bg", fg = "palette.comment" },
					ScrollbarHandle = { bg = "palette.blue.base" },
					FoldTag = { fg = "palette.yellow.base", bg = "palette.bg1" },
					NvimTreeNormal = { bg = "bg" },
					NeoTreeNormal = { bg = "bg" },
					NeoTreeStatuslineNC = { bg = "bg" },
					NeoTreeStatusline = { bg = "bg" },
					NeoTreeTabInactive = { bg = "palette.bg1", fg = "palette.fg3" },
					NeoTreeTabActive = { bg = "palette.bg1", fg = "palette.blue.base" },
					NeoTreeTabSeparatorActive = { fg = "palette.fg3" },
					NeoTreeTabSeparatorInactive = { fg = "palette.fg3" },
					NormalFloat = { bg = "bg" },
					NeoTreeFloatNormal = { bg = "bg" },
					MiniFilesBorder = { fg = "palette.comment" },
					BufferLineOffsetSeparator = { bg = "bg" },
					TelescopePromptTitle = { fg = "palette.bg1", bg = "palette.magenta.dim" },
					TelescopeResultsTitle = { fg = "palette.bg1", bg = "palette.green.dim" },
					TelescopePreviewTitle = { fg = "palette.bg1", bg = "palette.red.bright" },
					TelescopePreviewMatch = { bg = "palette.cyan.bright", fg = "palette.bg1" },
					SnacksPickerInputTitle = { fg = "palette.bg1", bg = "palette.magenta.dim" },
					SnacksPickerBorder = { fg = "palette.bg1", bg = "palette.bg1" },
					SnacksPickerListTitle = { fg = "palette.bg1", bg = "palette.green.dim" },
					SnacksPickerPreviewTitle = { fg = "palette.bg1", bg = "palette.red.bright" },
					LlmGrayLight = { fg = "palette.fg0" },
				},
				nordfox = {
					BlinkCmpMenuSelection = { bg = "palette.black.bright" },
					TelescopePromptNormal = { bg = "palette.black.base" },
					TelescopePromptBorder = { bg = "palette.black.base" },
					LLMPromptNormal = { bg = "palette.black.base" },
					SnacksPickerInputBorder = { fg = "palette.black.base", bg = "palette.black.base" },
					SnacksPickerInput = { bg = "palette.black.base" },
				},
				dawnfox = {
					BlinkCmpMenuSelection = { bg = "palette.sel0" },
					TelescopePromptNormal = { bg = "palette.bg0" },
					TelescopePromptBorder = { bg = "palette.bg0" },
					LLMPromptNormal = { bg = "palette.bg0" },
					SnacksPickerInput = { bg = "palette.bg0" },
					SnacksPickerInputBorder = { fg = "palette.bg0", bg = "palette.bg0" },
				},
				dayfox = {
					BlinkCmpMenuSelection = { bg = "palette.bg0" },
					TelescopePromptNormal = { bg = "palette.bg0" },
					TelescopePromptBorder = { bg = "palette.bg0" },
					LLMPromptNormal = { bg = "palette.bg0" },
					SnacksPickerInput = { bg = "palette.bg0" },
					SnacksPickerInputBorder = { fg = "palette.bg0", bg = "palette.bg0" },
				},
				duskfox = {
					BlinkCmpMenuSelection = { bg = "palette.bg3" },
					TelescopePromptNormal = { bg = "palette.black.base" },
					TelescopePromptBorder = { bg = "palette.black.base" },
					LLMPromptNormal = { bg = "palette.black.base" },
					SnacksPickerInputBorder = { fg = "palette.black.base", bg = "palette.black.base" },
					SnacksPickerInput = { bg = "palette.black.base" },
				},
				terafox = {
					BlinkCmpMenuSelection = { bg = "palette.bg3" },
					TelescopePromptNormal = { bg = "palette.bg2" },
					TelescopePromptBorder = { bg = "palette.bg2" },
					LLMPromptNormal = { bg = "palette.bg2" },
					SnacksPickerInputBorder = { fg = "palette.bg2", bg = "palette.bg2" },
					SnacksPickerInput = { bg = "palette.bg2" },
				},
				carbonfox = {
					BlinkCmpMenuSelection = { bg = "palette.bg3" },
					TelescopePromptNormal = { bg = "palette.bg2" },
					TelescopePromptBorder = { bg = "palette.bg2" },
					LLMPromptNormal = { bg = "palette.bg2" },
					SnacksPickerInputBorder = { fg = "palette.bg2", bg = "palette.bg2" },
					SnacksPickerInput = { bg = "palette.bg2" },
				},
				nightfox = {
					BlinkCmpMenuSelection = { bg = "palette.bg3" },
					TelescopePromptNormal = { bg = "palette.bg2" },
					TelescopePromptBorder = { bg = "palette.bg2" },
					LLMPromptNormal = { bg = "palette.bg2" },
					SnacksPickerInputBorder = { fg = "palette.bg2", bg = "palette.bg2" },
					SnacksPickerInput = { bg = "palette.bg2" },
				},
			}

			local options = {
				transparent = true, -- Disable setting background
				terminal_colors = false, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = true, -- Non focused panes set to alternative background
                -- stylua: ignore
                palettes = {
                    nordfox = { red = "#e17393", },
                    nightfox = { red = "#e8688c", },
                },
				groups = highlights,
				options = {
					styles = { comments = "italic", keywords = "bold", types = "italic,bold" },
				},
			}
			return options
		end,
	},
}
