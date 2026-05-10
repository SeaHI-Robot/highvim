return {
	{
		-- "Kurama622/llm.nvim",
		"syw-robotics/llm.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
		config = function()
			local tools = require("llm.tools")
			local ui = require("llm.common.ui")
			local Text = require("nui.text")

			local is_bordless = TelescopeBordless
			local winhighlight_input =
				"Normal:LLMPromptNormal,FloatBorder:LLMPromptNormal,FloatTitle:TelescopePromptTitle"
			local winhighlight_output = "FloatTitle:TelescopeResultsTitle"
			local winhighlight_history = "FloatTitle:TelescopePreviewTitle"
			local winhighlight_models = "FloatTitle:TelescopePreviewMatch"
			local winhighlight_handler_input =
				"Normal:LLMHandlerPromptNormal,FloatBorder:LLMHandlerPromptBorder,FloatTitle:TelescopePromptTitle"
			local winhighlight_handler_preview = "Normal:LLMHandlerPreviewNormal,FloatBorder:LLMHandlerPreviewBorder"

			if not is_bordless then
				winhighlight_output =
					"Normal:LLMDarkNormal,FloatBorder:TelescopeResultsBorder,FloatTitle:TelescopeResultsTitle"
				winhighlight_history =
					"Normal:LLMDarkNormal,FloatBorder:TelescopeResultsBorder,FloatTitle:TelescopePreviewTitle"
				winhighlight_models =
					"Normal:LLMDarkNormal,FloatBorder:TelescopeResultsBorder,FloatTitle:TelescopePreviewMatch"
			end

			local TranslatorHandler = function(prompt, title, title_hl)
				return {
					handler = tools.qa_handler,
					prompt = prompt,
					opts = {
						component_width = "50%",
						component_height = "50%",
						query = {
							title = title,
							hl = { link = title_hl },
						},
						input_box_opts = {
							size = "15%",
							border = "solid",
							win_options = { winhighlight = winhighlight_handler_input },
						},
						preview_box_opts = {
							size = "85%",
							border = "solid",
							win_options = { winhighlight = winhighlight_handler_preview },
						},
					},
				}
			end

			require("llm").setup({
				models = {
					{ -- [[ GLM ]]
						name = "GLM",
						url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
						model = "glm-4-flash",
						api_type = "zhipu",
						max_tokens = 4096,
						temperature = 0.3,
						top_p = 0.7,
						fetch_key = function()
							return vim.env.GLM_API
						end,
						-- enable_thinking = true,
						-- thinking_budget = 512,
					},
					{ -- [[ Github Models ]]
						name = "GPT4o-mini",
						url = "https://models.inference.ai.azure.com/chat/completions",
						-- model = "gpt-4o",
						model = "gpt-4o-mini",
						api_type = "openai",
						fetch_key = function()
							return vim.env.GITHUB_API
						end,
					},
					{ -- [[ Kimi ]]
						name = "Kimi",
						url = "https://api.moonshot.cn/v1/chat/completions",
						model = "moonshot-v1-128k",
						api_type = "openai",
						fetch_key = function()
							return vim.env.KIMI_API
						end,
					},
					{ -- [[ Ollama ]]
						name = "Ollama",
						url = "http://localhost:11434/api/chat",
						model = "qwen2.5-coder:7b",
						api_type = "ollama",
						max_tokens = 4096,
						temperature = 0.3,
						top_p = 0.7,
						fetch_key = function()
							return vim.env.OLLAMA_API
						end,
					},
				},

				prompt = "You are helpful chinese assistant",
				-- prompt = "You are helpful chinese assistant, markdown wrapeed with $ if needed",
                -- stylua: ignore
				chat_ui_opts = {
					relative = "editor",
					position = "50%",
					size = { width = "85%", height = "85%", },
					input = {
						float = {
                            border = { style = "solid", text = { top = Text(" User Input "), }, },
                            win_options = { winhighlight = winhighlight_input, },
							size = { height = "10%", width = "80%" },
						},
					},
					output = {
						float = {
                            border = { style = "solid", text = { top = Text(" Chat "), }, },
                            win_options = { winhighlight = winhighlight_output, },
							size = { height = "90%", width = "80%" },
						},
					},
                    history = {
                        float = {
                            border = { style = "solid" },
                            win_options = { winhighlight = winhighlight_history, },
                        },
                    },
                    models = {
                        float = {
                            border = { style = "solid" },
                            win_options = { winhighlight = winhighlight_models, },
                        },
                    },
				},

				prefix = {
					user = { text = "😃 ", hl = "Title" },
					assistant = { text = "🤖 ", hl = "Added" },
				},
				spinner = {
					-- text = { "⣾", "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽" },
					text = { "∙∙∙", "●∙∙", "∙●∙", "∙∙●", "∙∙∙" },
					hl = "Title",
				},

				-- history_path = "blabla",    -- where to save history; Default: ~/.local/state/nvim/llm-history/
				history_timestamp_format = "%m-%d-%y",
				save_session = true,
				max_history = 15,
				max_history_name_length = 20,

                -- stylua: ignore
                keys = {
                    -- The keyboard mapping for the input window.
                    ["Input:Submit"]      = { mode = {"n", "i"}, key = { "<C-s>" } },
                    ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-x>" },
                    ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },
          
                    -- only works when "save_session = true"
                    ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
                    ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },
          
                    -- The keyboard mapping for the output window in "split" style.
                    ["Output:Ask"]        = { mode = "n", key = "i" },
                    ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
                    ["Output:Resend"]     = { mode = "n", key = "<C-r>" },
          
                    -- The keyboard mapping for the output and input windows in "float" style.
                    ["Session:Toggle"]    = { mode = "i", key = "<C-c>" },
                    ["Session:Close"]     = { mode = "n", key = {"<esc>", "q", "<C-c>"} },
          
                    -- Scroll
                    ["PageUp"]            = { mode = {"i","n"}, key = "<C-b>" },
                    ["PageDown"]          = { mode = {"i","n"}, key = "<C-f>" },
                    ["HalfPageUp"]        = { mode = {"i","n"}, key = "<C-u>" },
                    ["HalfPageDown"]      = { mode = {"i","n"}, key = "<C-d>" },
                    ["JumpToTop"]         = { mode = "n", key = "gg" },
                    ["JumpToBottom"]      = { mode = "n", key = "G" },

                    -- Switch from the output window to the input window.
                    ["Focus:Input"]       = { mode = "n", key = {"i", "<C-w>"} },
                    -- Switch from the input window to the output window.
                    ["Focus:Output"]      = { mode = { "n", "i" }, key = "<C-w>" },

                    -- float style
                    ["Input:ModelsNext"]  = { mode = {"n", "i"}, key = "<A-]>" },
                    ["Input:ModelsPrev"]  = { mode = {"n", "i"}, key = "<A-[>" },

                    -- Applicable to AI tools with split style and UI interfaces
                    -- ["Session:Models"]     = { mode = "n", key = {"<C-m>"} },
                },
				app_handler = {
					AskInline = {
						handler = tools.disposable_ask_handler,
						opts = {
							position = {
								row = 1,
								col = 0,
							},
							title = " Inline Ask ",
							inline_assistant = true,
							language = "Chinese",
							-- [optinal] set your llm model
							url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
							model = "glm-4-flash",
							api_type = "zhipu",
							max_tokens = 4096,
							temperature = 0.3,
							top_p = 0.7,
							fetch_key = function()
								return vim.env.GLM_API
							end,
							-- display diff
							display = {
								mapping = {
									mode = "n",
									keys = { "d" },
								},
								action = nil,
							},
							-- accept diff
							accept = {
								mapping = {
									mode = "n",
									keys = { "Y", "y" },
								},
								action = nil,
							},
							-- reject diff
							reject = {
								mapping = {
									mode = "n",
									keys = { "N", "n" },
								},
								action = nil,
							},
							-- close diff
							close = {
								mapping = {
									mode = "n",
									keys = { "<esc>" },
								},
								action = nil,
							},
						},
					},
					AskInline = {
						handler = tools.disposable_ask_handler,
                        -- stylua: ignore
						opts = {
							position = { row = 3, col = 0, },
							title = " Inline Ask ",
							inline_assistant = true,
							language = "Chinese",
							-- [optinal] set your llm model
							url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
							model = "glm-4-flash",
							api_type = "zhipu",
							max_tokens = 4096,
							temperature = 0.3,
							top_p = 0.7,
							fetch_key = function()
								return vim.env.GLM_API
							end,
                            size = { width = "50%", height = "5%", },
							win_options = { winhighlight = winhighlight_handler_input },
							border = { style = "solid", text = { top = " Ask Inline " } },
							close = { mapping = { mode = "n", keys = { "<esc>", "q" } },
							},
						},
					},
					Translate_ch2en_qa = TranslatorHandler(
						"Translate Chinese to English: ",
						" 󰊿 Trans ch2en ",
						"TelescopeResultsTitle"
					),
					Translate_en2ch_qa = TranslatorHandler(
						"Translate English to Chinese: ",
						" 󰊿 Trans en2ch ",
						"TelescopeResultsTitle"
					),
					WordTranslate = {
						handler = tools.flexi_handler,
						prompt = [[Translate all the text provided by the user into Chinese. RETURN ONLY THE TRANSLATED RESULT.]],
						opts = {
							close = { mapping = { mode = "n", keys = { "<esc>", "q" } } },
							win_opts = {
								position = { row = 1, col = 0 },
								border = { style = "solid" },
								win_options = { winhighlight = winhighlight_handler_input },
							},
						},
					},
					AttachToChat = {
						handler = tools.attach_to_chat_handler,
						opts = {
							inline_assistant = false,
							language = "Chinese",
							close = { mapping = { mode = "n", keys = { "<esc>", "q" } } },
						},
					},
				},
			})
		end,
		keys = {
			{ "<localleader><space>", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Toggle LLMSession" },
			{ "<localleader>ll", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Toggle LLMSession" },
			{ "<localleader>la", mode = { "v", "n" }, "<cmd>LLMAppHandler AskInline<cr>", desc = "LLM: Ask" },
			{
				"<localleader>lA",
				mode = "v",
				"<cmd>LLMAppHandler AttachToChat<cr>",
				desc = "LLM: Ask and attach to Chat",
			},
			{
				"<localleader>lt",
				mode = "v",
				"<cmd>LLMAppHandler WordTranslate<cr>",
				desc = "LLM: Translate the selected to Chinese",
			},
			{
				"<localleader>tc",
				mode = "n",
				"<cmd>LLMAppHandler Translate_en2ch_qa<cr>",
				desc = "LLM: Open a Translating Window [Ch to En]",
			},
			{
				"<localleader>te",
				mode = "n",
				"<cmd>LLMAppHandler Translate_ch2en_qa<cr>",
				desc = "LLM: Open a Translating Window [En to Ch]",
			},
		},
	},
}
