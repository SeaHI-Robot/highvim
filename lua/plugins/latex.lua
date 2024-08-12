return {
	{
		"lervag/vimtex",
		-- lazy = false, -- we don't want to lazy load VimTeX
		event = "VeryLazy",
		ft = { "tex" },
		-- tag = "v2.15", -- uncomment to pin to a specific release
		keys = {
			{ "<localleader>lc", mode = "n", "<Plug>(vimtex-compile)<cr>", desc = "[L]atex: [C]ompile" },
			{ "<localleader>li", mode = "n", "<Plug>(vimtex-info)<cr>", desc = "[L]atex: [I]nfo" },
			{ "<localleader>lC", mode = "n", "<Plug>(vimtex-clean)<cr>", desc = "[L]atex: [C]lean" },
			{ "<localleader>lv", mode = "n", "<Plug>(vimtex-view)<cr>", desc = "[L]atex: [V]iew" },
		},
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end,
		config = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_mappings_disable = {
				["n"] = { "K" },
			} -- disable `K` as it conflicts with LSP hover
			vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
			-- vimtex config
			-- \ll开启连续编译，\lv预览pdf，\lc清除文件
			-- 参考https://castel.dev/post/lecture-notes-1/
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_quickfix_mode = "0"
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.vimtex_compiler_latexmk_engines = {
				["_"] = "-xelatex",
			}
			vim.g.vimtex_compiler_latexrun_engines = {
				["_"] = "xelatex",
			}
			vim.g.vimtex_quickfix_mode = 0
			vim.opt.conceallevel = 1
			vim.g.tex_conceal = "abdmg"
		end,
	},
	{
		"let-def/texpresso.vim",
		event = "VeryLazy",
		ft = { "tex" },
		keys = {
			{ "<localleader>tx", mode = "n", "<cmd>TeXpresso %<cr>", desc = "[T]e[X]presso: render current Tex file" },
		},
	},
}
