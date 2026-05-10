return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy",
			enabled = true,
			config = function()
				-- When in diff mode, we want to use the default
				-- vim text objects c & C instead of the treesitter ones.
				local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
				local configs = require("nvim-treesitter.configs")
				for name, fn in pairs(move) do
					if name:find("goto") == 1 then
						move[name] = function(q, ...)
							if vim.wo.diff then
								local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
								for key, query in pairs(config or {}) do
									if q == query and key:find("[%]%[][cC]") then
										vim.cmd("normal! " .. key)
										return
									end
								end
							end
							return fn(q, ...)
						end
					end
				end
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			keys = {
				{
					"<localleader>ut",
					function()
						vim.cmd("TSContextToggle")
					end,
					desc = "Toggle TSContext",
					mode = { "n", "v" },
				},
			},
			opts = {
				enable = false,
				max_lines = 5,
				-- multiline_threshold = 10,
				on_attach = function(bufnr)
					local buftype = vim.bo[bufnr].buftype
					if buftype ~= "" and buftype ~= "acwrite" then
						return false
					end

					local ft = vim.bo[bufnr].filetype
					if ft == "" or ft:match("^snacks_") then
						return false
					end

					local lang = vim.treesitter.language.get_lang(ft)
					if not lang then
						return false
					end

					local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
					return ok and parser ~= nil
				end,
			},
		},
	},
	event = "VeryLazy",
	main = "nvim-treesitter.configs",
	build = ":TSUpdate",
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)

		vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
			local node = match[pred[2]]
			if type(node) == "table" then
				node = node[1]
			end
			if not node or type(node.range) ~= "function" then
				return
			end

			local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
			injection_alias = injection_alias:match("^%s*{%s*([%w_+-]+)") or injection_alias:match("^%s*([%w_+-]+)")
			if not injection_alias or injection_alias == "" then
				return
			end

			local aliases = {
				ex = "elixir",
				pl = "perl",
				sh = "bash",
				ts = "typescript",
			}
			metadata["injection.language"] = vim.filetype.match({ filename = "a." .. injection_alias })
				or aliases[injection_alias]
				or injection_alias
		end, { force = true })
	end,
	opts = {
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"cpp",
			"python",
			"markdown",
			"markdown_inline",
			"latex",
			"cmake",
			"bash",
			"html",
			"javascript",
		},
		ignore_install = { "latex" },
		disable = { "latex" },
		highlight = {
			enable = true,
			disable = { "latex" },
			additional_vim_regex_highlighting = { "latex" },
		},
		indent = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-n>",
				node_incremental = "<C-n>",
				node_decremental = "<C-m>",
				scope_incremental = false,
			},
		},
		textobjects = {
			move = {
				enable = true,
				goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
				goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner",
				},
				goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
			},
		},
	},
}
