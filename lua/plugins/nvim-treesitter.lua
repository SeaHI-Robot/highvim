return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy",
			enabled = true,
			config = function()
				local move = require("nvim-treesitter.textobjects.move")
				local modes = { "n", "x", "o" }
				local function map_move(lhs, method, query)
					vim.keymap.set(modes, lhs, function()
						-- In diff mode, keep Vim's built-in change hunk motions on [c/]c/[C/]C.
						if vim.wo.diff and lhs:find("[%]%[][cC]") then
							vim.cmd("normal! " .. lhs)
							return
						end
						move[method](query, "textobjects")
					end, { desc = "Treesitter textobject move " .. lhs })
				end

				map_move("]f", "goto_next_start", "@function.outer")
				map_move("]c", "goto_next_start", "@class.outer")
				map_move("]a", "goto_next_start", "@parameter.inner")
				map_move("]F", "goto_next_end", "@function.outer")
				map_move("]C", "goto_next_end", "@class.outer")
				map_move("]A", "goto_next_end", "@parameter.inner")
				map_move("[f", "goto_previous_start", "@function.outer")
				map_move("[c", "goto_previous_start", "@class.outer")
				map_move("[a", "goto_previous_start", "@parameter.inner")
				map_move("[F", "goto_previous_end", "@function.outer")
				map_move("[C", "goto_previous_end", "@class.outer")
				map_move("[A", "goto_previous_end", "@parameter.inner")
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
	lazy = false,
	build = function()
		if vim.fn.executable("tree-sitter") == 1 then
			vim.cmd("TSUpdate")
		end
	end,
	config = function(_, opts)
		local treesitter = require("nvim-treesitter")
		treesitter.setup()
		require("nvim-treesitter.configs").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
			pattern = {
				"bash",
				"c",
				"cmake",
				"cpp",
				"html",
				"javascript",
				"lua",
				"markdown",
				"python",
				"sh",
				"vim",
			},
			callback = function()
				if pcall(vim.treesitter.start) then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

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
			"cmake",
			"bash",
			"html",
			"javascript",
		},
	},
}
