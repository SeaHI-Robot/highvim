return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
						{ path = "snacks.nvim", words = { "Snacks" } },
					},
				},
			},
			-- {
			--	   -- lspsaga.nvim is abandoned
			--     "nvimdev/lspsaga.nvim",
			--     event = "VeryLazy",
			--     opts = {
			--         rename = {
			--             in_select = false,
			--             keys = {
			--                 quit = "<esc>",
			--                 close = "<ESC>",
			--                 vsplit = "<C-v>",
			--                 tabe = "<C-t>",
			--             },
			--         },
			--         definition = { width = 0.8, height = 0.8, },
			--         floaterm = { height = 0.8, width = 0.8, },
			--         scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>", },
			--         lightbulb = { enable = false, },
			--     },
			-- },
			-- {
			--     "jinzhongjia/LspUI.nvim",
			--     branch = "main",
			--     -- 和 lspsaga 中UI组件类似的功能
			-- },
			{
				-- "navbuddy": 类似ranger、yazi的outline导航插件
				"SmiteshP/nvim-navbuddy",
				cmd = "Navbuddy",
				dependencies = { "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
				config = function()
					local navbuddy = require("nvim-navbuddy")
					local actions = require("nvim-navbuddy.actions")
					navbuddy.setup({
						window = {
							border = "rounded", -- "rounded", "double", "solid", "none"
							-- or an array with eight chars building up the border in a clockwise fashion
							-- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
							size = "80%", -- Or table format example: { height = "40%", width = "100%"}
							position = "50%", -- Or table format example: { row = "100%", col = "0%"}
							scrolloff = nil, -- scrolloff value within navbuddy window
							sections = {
								left = {
									size = "20%",
									border = nil, -- You can set border style for each section individually as well.
								},
								mid = {
									size = "40%",
									border = nil,
								},
								right = {
									-- No size option for right most section. It fills to
									-- remaining area.
									border = nil,
									preview = "leaf", -- Right section can show previews too.
									-- Options: "leaf", "always" or "never"
								},
							},
						},
						mappings = {
							["<C-c>"] = actions.close(),
						},
						lsp = {
							auto_attach = true,
						},
					})
				end,
			},
		},
		ft = { "lua", "python", "cmake", "cpp", "c", "markdown", "tex", "json", "yaml" },
		cmd = { "Mason" },
		keys = {
			-- { "<localleader>f<space>", "<cmd>Lspsaga term_toggle<CR>", desc = "Toggle FLoat Termial", mode = { "n" } },
			{ "<localleader>e", "<cmd>Navbuddy<CR>", desc = "Toggle Navbuddy", mode = { "n" } },
			-- { "<localleader>O",        "<cmd>Lspsaga outline<CR>",     desc = "Toggle Outline",       mode = { "n" } }, -- Outline functionality is provided by outline.nvim
		},
		opts = {
			inlay_hints = { enable = true },
		},
		config = function() -- mason需要加载的language server
			local servers = {
				lua_ls = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
						completion = {
							autoRequire = true,
							callSnippet = "Replace",
							displayContext = 1,
						},
						hint = {
							enable = true,
							arrayIndex = "Enable",
							setType = true,
						},
						diagnostics = {
							-- Ignore some warnings when some variables not found
							globals = {
								"vim",
								"require",
								"opts",
								"Snacks",
							},
						},
					},
					codelens = {
						enable = true,
					},
				},
				-- ========== Python LSP ========== --
				-- jedi_language_server = {
				--
				-- },
				pyright = {
					python = {
						analysis = {
							typeCheckingMode = "off",
							autoSearchPaths = true,
							useLibraryDorTypes = true,
						},
						codelens = {
							enable = true,
						},
					},
				},
				-- ruff = {},
				-- mypy = {},
				-- ========== Python LSP ========== --
				clangd = { capabilities = { offsetEncoding = "utf-8" }, cmd = { "clangd" } },
				vimls = {},
				-- matlab_ls = {},
				cmake = {},
				jsonls = {},
				texlab = {},
				-- harper_ls = {
				--     userDictPath = vim.fn.expand("~/.config/nvim/dict/harper_dict.txt"),  -- I have no idea how to ignore certain words in harper_ls
				-- },
			}

			local on_attach = function(_, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, {
						buffer = bufnr,
						desc = desc,
						noremap = true,
					})
				end
				-- nmap("gD", "<cmd>Lspsaga peek_definition<CR>", "Peek [D]eclaration ")
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("gd", function()
					require("telescope.builtin").lsp_definitions()
				end, "[G]oto [D]efinition")
				nmap("gi", function()
					require("telescope.builtin").lsp_implementations()
				end, "[G]oto [I]mplementation")
				nmap("gr", function()
					require("telescope.builtin").lsp_references()
				end, "[G]oto [R]eferences")
				-- nmap("gt", "<cmd>Lspsaga peek_type_definition<CR>", "[T]ype [D]efinition")
				nmap("gt", function()
					require("telescope.builtin").lsp_type_definitions()
				end, "[T]ype [D]efinition")
				-- nmap('K', "<cmd>Lspsaga hover_doc<CR>", 'Hover Documentation')
				nmap("K", function()
					vim.lsp.buf.hover()
				end, "Hover Doc: Calling Twice to Jump Into Hover Window")
				nmap("<localleader>k", vim.lsp.buf.signature_help, "Signature Documentation")
				nmap("<localleader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<localleader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<localleader>wl", function()
					print("WorkSpace " .. vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")
				nmap("<localleader>ws", function()
					require("telescope.builtin").lsp_dynamic_workspace_symbols()
				end, "[W]orkspace [S]ymbols")
				nmap("<localleader>ds", function()
					require("telescope.builtin").lsp_document_symbols()
				end, "[D]ocument [S]ymbols")
				-- nmap("<localleader>rn", "<cmd>Lspsaga rename<CR>", "[R]e[N]ame in Project Scope")
				nmap("<localleader>rn", vim.lsp.buf.rename, "[R]e[N]ame in Project Scope")
				-- nmap("<localleader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
				nmap("<localleader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction") -- code action is not quite useful, often gives wrong suggestions
				nmap("<localleader>da", function()
					require("telescope.builtin").diagnostics()
				end, "[D]i[A]gonostics")
				nmap("<localleader>fF", function()
					local filetype = vim.bo.filetype
					if filetype == "python" then
						-- ===== Format Using black-macchiato. Need to install: pip install black-macchiato =====
						-- vim.api.nvim_feedkeys("ggVG", "n", true)
						-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":", true, false, true), "n", true)
						-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("!python -m macchiato", true, false, true), "n",
						--     true)
						-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
						-- vim.api.nvim_feedkeys("<C-o>", "n", true)
						-- ===== Format using black in terminal =====
						vim.cmd("!black --line-length 120 --preview %")
					elseif filetype == "lua" then
						vim.cmd("!stylua --column-width 120 %")
					elseif filetype ~= "markdown" then
						vim.lsp.buf.format({
							async = true,
						})
					end
					vim.notify("File Formatted !", vim.log.levels.INFO, { title = "Formatter" })
				end, "[F]ormat code")
				-- nmap("<localleader>cc", function()
				--     local filetype = vim.bo.filetype
				--     if filetype == "python" then
				--         vim.cmd("!flake8 %")
				--     end
				--     -- vim.notify("File Formatted !", vim.log.levels.INFO, { title = "Formatter" })
				-- end, "[C]ode [C]heck")

				vim.lsp.codelens.refresh({ bufnr = bufnr })
				vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
					buffer = bufnr,
					callback = function()
						vim.lsp.codelens.refresh({
							bufnr = bufnr,
						})
					end,
				})
			end

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			-- Settings for completion
			for server, config in pairs(servers) do
				-- LSP settings for nvim-cmp completion
				if vim.g.use_nvim_cmp then
					vim.lsp.config(
						server,
						vim.tbl_deep_extend("keep", {
							on_attach = on_attach,
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						}, config)
					)
				end

				-- -- LSP settings for blink.cmp completion
				if vim.g.use_blink_cmp then
					config.on_attach = on_attach
					config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
					vim.lsp.config(server, config)
				end
			end
		end,
	},
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		-- event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = { -- "black", "debugpy", -- "mypy",
				"ruff_lsp",
				"clangd",
				"clang-format",
				"lua_ls",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				keymaps = {
					---@since 1.8.0
					-- Keymap to toggle the help view
					toggle_help = "?",
				},
			},
			pip = { "--proxy", "https://pypi.tuna.tsinghua.edu.cn/simple" },
		},
	},
}
