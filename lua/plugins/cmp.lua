local which_cmp = "blink.cmp"
-- local which_cmp = "nvim-cmp"

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = {
					"L3MON4D3/LuaSnip",
					version = "v2.3.0", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
					-- dependencies = {
					--     "rafamadriz/friendly-snippets"
					-- }
				},
				event = "VeryLazy",
			},
		},
		event = "VeryLazy",
		-- ft = { "c", "cpp", "lua", "vim", "markdown", "tex", "yaml", "json", "toml", "bash", "javascript", "cmake", "snippets"},
		config = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			vim.g.use_nvim_cmp = true

			-- 使用snipmate的snippet格式，并加载vim-snippets和我的snipmate的snippets的路径
			require("luasnip.loaders.from_snipmate").lazy_load({
				paths = { "~/.config/nvim/snippets/my_snippets/", "~/.config/nvim/snippets/vim-snippets/" },
			})

			-- load snippets from path/of/your/nvim/config/my-cool-snippets, 目标目录需要包含package.json
			-- require("luasnip.loaders.from_vscode").load({ paths = { "~/.vscode/High-ROS-Snippets/" } })
			-- require("luasnip.loaders.from_vscode").load({ paths = { "~/.vscode/High-ROS2-Snippets/" } })

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			local formatting_style = {
				format = function(_, item)
					local icons = {
						Namespace = "󰌗",
						Text = "󰉿",
						Method = "󰆧",
						Function = "󰆧",
						Constructor = "",
						Field = "󰜢",
						Variable = "󰀫",
						Class = "󰠱",
						Interface = "",
						Module = "",
						Property = "󰜢",
						Unit = "󰑭",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "󰏘",
						File = "󰈚",
						Reference = "󰈇",
						Folder = "󰉋",
						EnumMember = "",
						Constant = "󰏿",
						Struct = "󰙅",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "󰊄",
						Table = "",
						Object = "󰅩",
						Tag = "",
						Array = "[]",
						Boolean = "",
						Number = "",
						Null = "󰟢",
						Supermaven = "",
						String = "󰉿",
						Calendar = "",
						Watch = "󰥔",
						Package = "",
						Copilot = "",
						Codeium = "",
						TabNine = "",
					}
					local icon = icons[item.kind]
					icon = " " .. icon
					item.menu = " " .. item.kind
					item.kind = icon
					return item
				end,
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "render-markdown" },
				}),
				mapping = cmp.mapping.preset.insert({
					-- Tab 跳转到下一个补全项
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					-- Shift + Tab 跳转到上一个补全项
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					-- Down 跳转到下一个补全项
					["<Down>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					-- Up 跳转到上一个补全项
					["<Up>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					-- Ctrl + j 跳转到下一个补全项
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					-- Ctrl + k 跳转到上一个补全项
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					-- 确认补全选项
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),
					-- 文档翻页
					["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					-- 取消补全
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					["<C-c>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					-- ['<esc>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
				}),
				window = {
					completion = {
						side_padding = 1, -- 1 or 0
						winhighlight = "Normal:Normal,CursorLine:PmenuSel,Search:PmenuSel",
						scrollbar = true,
						border = border("CmpDocBorder"),
					},
					documentation = {
						border = border("CmpDocBorder"),
						winhighlight = "Normal:CmpDoc",
					},
				},
				formatting = formatting_style,
				experimental = {
					ghost_text = true,
				},
				sorting = require("cmp.config/default")().sorting,
			})

			-- /搜索的时候进行补全
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- 命令行进行补全
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})

			-- nvim-autopairs config
			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
		cond = function()
			if which_cmp == "nvim-cmp" then
				return true
			end
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.3.0", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			},
		},
		-- use a release tag to download pre-built binaries
		version = "*",
		event = "VeryLazy",
		config = function(_, opts)
			-- 使用snipmate的snippet格式，并加载vim-snippets和我的snipmate的snippets的路径
			require("luasnip.loaders.from_snipmate").lazy_load({
				paths = {
					"~/.config/nvim/snippets/my_snippets/",
					"~/.config/nvim/snippets/vim-snippets/",
					"~/.vscode/High-ROS2-Snippets/",
				},
			})

			require("blink.cmp").setup(opts)
		end,
		opts = {
			enabled = function()
				return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
			end,
			keymap = {
				preset = "enter",
				-- Toggle select
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				-- Jump between selections
				-- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				-- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				-- Super Tab
				["<Tab>"] = {
					function(cmp)
						return cmp.select_next()
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						return cmp.select_prev()
					end,
					"snippet_backward",
					"fallback",
				},
				["<C-j>"] = { "snippet_forward", "select_next", "fallback" }, -- snippets have higher priority
				["<C-k>"] = { "snippet_backward", "select_prev", "fallback" },
				-- Scroll selection menu
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-y>"] = { "select_and_accept", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			cmdline = {
				keymap = {
					preset = "default",
					-- Toggle select
					["<C-space>"] = { "show", "fallback" },
					-- Jump between selections
					["<Tab>"] = { "show", "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<C-j>"] = { "snippet_forward", "select_next", "fallback" }, -- snippets have higher priority
					["<C-k>"] = { "snippet_backward", "select_prev", "fallback" },
					-- Scroll selection menu
					["<C-u>"] = { "scroll_documentation_up", "fallback" },
					["<C-d>"] = { "scroll_documentation_down", "fallback" },
					["<C-y>"] = { "select_and_accept", "fallback" },
					["<CR>"] = { "accept_and_enter", "fallback" },
				},
				completion = {
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype() == ":"
								-- enable for inputs as well, with:
								or vim.fn.getcmdtype() == "/"
						end,
					},
					ghost_text = { enabled = true },
					list = {
						selection = {
							-- When `true`, will automatically select the first item in the completion list
							preselect = false,
							-- When `true`, inserts the completion item automatically when selecting it
							auto_insert = true,
						},
					},
				},
			},
			completion = {
				-- keyword = { range = "full" },
				keyword = { range = "prefix" },
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "kind_icon", gap = 1 },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
						padding = { 0, 1 },
						treesitter = { "lsp" },
						components = {
							kind_icon = {
								text = function(ctx)
									return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
								end,
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					window = {
						border = "rounded",
					},
				},
				list = {
					selection = {
						-- preselect = false,
						preselect = function(ctx)
							return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
						end,
						auto_insert = false,
					},
				},
				ghost_text = { enabled = false },
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			sources = {
				-- default = { "buffer", "lsp", "path", "snippets" },
				default = { "lsp", "buffer", "path", "snippets", "lazydev" },
				providers = {
					lsp = { score_offset = 2 },
					path = { score_offset = 3 },
					snippets = { score_offset = 1 },
					buffer = { score_offset = 0 },
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			snippets = {
				preset = "luasnip",
			},
			signature = {
				enabled = true,
				-- window = { border = "single" }
				window = { border = "rounded" },
			},
		},
		opts_extend = { "sources.default" },
		cond = function()
			if which_cmp == "blink.cmp" then
				vim.g.use_blink_cmp = true

				return true
			end
		end,
	},
}
