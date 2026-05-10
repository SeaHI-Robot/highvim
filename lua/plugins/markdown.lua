return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		-- build = function(plugin)
		--     if vim.fn.executable "npx" then
		--         vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
		--     else
		--         vim.cmd [[Lazy load markdown-preview.nvim]]
		--         vim.fn["mkdp#util#install"]()
		--     end
		-- end,
		init = function()
			if vim.fn.executable("npx") then
				vim.g.mkdp_filetypes = { "markdown" }
			end
		end,
	},
	{
		"Kicamon/markdown-table-mode.nvim",
		ft = { "markdown", "quarto" },
		cmd = "Mtm",
		opts = {
			filetype = {
				"*.md",
				"*.qmd",
			},
			options = {
				insert = true, -- when typing "|"
				insert_leave = true, -- when leaving insert
				pad_separator_line = false, -- add space in separator line
				alig_style = "default", -- default, left, center, right
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			-- {
			--     "jbyuki/nabla.nvim",
			--     ft = { "markdown", "Avante" },
			--     keys = {
			--         {
			--             "K",
			--             '<cmd>lua require("nabla").popup()<cr>',
			--             desc = "Preview Latex Formula in markdown",
			--             mode = "n",
			--         },
			--     },
			-- },
		}, -- if you prefer nvim-web-devicons
		ft = { "markdown", "Avante", "llm" },
		opts = {
			latex = {
				enabled = true,
				render_modes = false,
				converter = "latex2text",
				highlight = "RenderMarkdownMath",
				position = "above",
				top_pad = 0,
				bottom_pad = 0,
			},
			win_options = { conceallevel = { rendered = 2 } },
			-- -- nabla configuration (I don't like nabla's render result)
			-- on = {
			--     render = function()
			--         require("nabla").enable_virt({ autogen = true })
			--     end,
			--     clear = function()
			--         require("nabla").disable_virt()
			--     end,
			-- },
			file_types = { "markdown", "Avante", "llm" },
			completions = {
				lsp = { enabled = true },
				completions = { blink = { enabled = true } }, -- enable for blink.cmp
			},
			callout = { -- callout works for github markdown render: https://docs.github.com/zh/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts
				note = {
					raw = "[!NOTE]",
					rendered = "󰋽 Note",
					highlight = "RenderMarkdownInfo",
					category = "github",
				},
				tip = {
					raw = "[!TIP]",
					rendered = "󰌶 Tip",
					highlight = "RenderMarkdownSuccess",
					category = "github",
				},
				important = {
					raw = "[!IMPORTANT]",
					rendered = "󰅾 Important",
					highlight = "RenderMarkdownHint",
					category = "github",
				},
				warning = {
					raw = "[!WARNING]",
					rendered = "󰀪 Warning",
					highlight = "RenderMarkdownWarn",
					category = "github",
				},
				caution = {
					raw = "[!CAUTION]",
					rendered = "󰳦 Caution",
					highlight = "RenderMarkdownError",
					category = "github",
				},
				abstract = {
					raw = "[!ABSTRACT]",
					rendered = "󰨸 Abstract",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				summary = {
					raw = "[!SUMMARY]",
					rendered = "󰨸 Summary",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				tldr = {
					raw = "[!TLDR]",
					rendered = "󰨸 Tldr",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				info = {
					raw = "[!INFO]",
					rendered = "󰋽 Info",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				todo = {
					raw = "[!TODO]",
					rendered = "󰗡 Todo",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				hint = {
					raw = "[!HINT]",
					rendered = "󰌶 Hint",
					highlight = "RenderMarkdownSuccess",
					category = "obsidian",
				},
				success = {
					raw = "[!SUCCESS]",
					rendered = "󰄬 Success",
					highlight = "RenderMarkdownSuccess",
					category = "obsidian",
				},
				check = {
					raw = "[!CHECK]",
					rendered = "󰄬 Check",
					highlight = "RenderMarkdownSuccess",
					category = "obsidian",
				},
				done = {
					raw = "[!DONE]",
					rendered = "󰄬 Done",
					highlight = "RenderMarkdownSuccess",
					category = "obsidian",
				},
				question = {
					raw = "[!QUESTION]",
					rendered = "󰘥 Question",
					highlight = "RenderMarkdownWarn",
					category = "obsidian",
				},
				help = {
					raw = "[!HELP]",
					rendered = "󰘥 Help",
					highlight = "RenderMarkdownWarn",
					category = "obsidian",
				},
				faq = {
					raw = "[!FAQ]",
					rendered = "󰘥 Faq",
					highlight = "RenderMarkdownWarn",
					category = "obsidian",
				},
				attention = {
					raw = "[!ATTENTION]",
					rendered = "󰀪 Attention",
					highlight = "RenderMarkdownWarn",
					category = "obsidian",
				},
				failure = {
					raw = "[!FAILURE]",
					rendered = "󰅖 Failure",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				fail = {
					raw = "[!FAIL]",
					rendered = "󰅖 Fail",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				missing = {
					raw = "[!MISSING]",
					rendered = "󰅖 Missing",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				danger = {
					raw = "[!DANGER]",
					rendered = "󱐌 Danger",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				error = {
					raw = "[!ERROR]",
					rendered = "󱐌 Error",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				bug = {
					raw = "[!BUG]",
					rendered = "󰨰 Bug",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				example = {
					raw = "[!EXAMPLE]",
					rendered = "󰉹 Example",
					highlight = "RenderMarkdownHint",
					category = "obsidian",
				},
				quote = {
					raw = "[!QUOTE]",
					rendered = "󱆨 Quote",
					highlight = "RenderMarkdownQuote",
					category = "obsidian",
				},
				cite = {
					raw = "[!CITE]",
					rendered = "󱆨 Cite",
					highlight = "RenderMarkdownQuote",
					category = "obsidian",
				},
			},
		},
	},
	-- {
	--     -- support for image pasting
	--     "HakonHarnes/img-clip.nvim",
	--     event = "VeryLazy",
	--     opts = {
	--         -- recommended settings
	--         default = {
	--             embed_image_as_base64 = false,
	--             prompt_for_file_name = false,
	--             drag_and_drop = {
	--                 insert_mode = true,
	--             },
	--             -- required for Windows users
	--             use_absolute_path = false,
	--         },
	--         filetypes = {
	--             markdown = {
	--                 url_encode_path = true,
	--                 template = "![$CURSOR]($FILE_PATH)",
	--                 drag_and_drop = {
	--                     download_images = false,
	--                 },
	--             },
	--             quarto = {
	--                 url_encode_path = true,
	--                 template = "![$CURSOR]($FILE_PATH)",
	--                 drag_and_drop = {
	--                     download_images = false,
	--                 },
	--             },
	--         },
	--     },
	--     ft = { "markdown", "Avante", "quarto" },
	--     -- keys = {
	--     --     { "<localleader>i", mode = { "i" }, "<Cmd>PasteImage<CR>", desc = "PasteImage" },
	--     -- },
	-- },
	-- {
	--     "MeanderingProgrammer/markdown.nvim",
	--     main = "render-markdown",
	--     ft = { "markdown" },
	--     -- keys = { -- If these are added, pressing tab conflicts
	--     --     { "<C-i>", "**<left>", desc = "Markdown: Italic", mode = { "i" } },
	--     --     { "<C-b>", "****<left><left>", desc = "Markdown: Bold", mode = { "i" } },
	--     -- },
	--     opts = {},
	--     dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	-- },
	--
}
