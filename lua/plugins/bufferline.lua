return {
	"akinsho/bufferline.nvim",
	-- event = "BufEnter",
	event = "VeryLazy",
	keys = {
		{ "<localleader>bP", "<Cmd>BufferLineTogglePin<CR>", desc = "[B]uffer: Toggle [P]in" },
		{
			"<localleader>bC",
			"<Cmd>BufferLineGroupClose ungrouped<CR>",
			desc = "[B]uffer: [C]lose Non-Pinned Buffers",
		},
		{ "<localleader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "[B]uffer: Close [O]ther Buffers" },
		{
			"<localleader>br",
			"<Cmd>BufferLineCloseRight<CR>",
			desc = "[B]uffer: Delete Buffers to the [R]ight",
		},
		{
			"<localleader>bl",
			"<Cmd>BufferLineCloseLeft<CR>",
			desc = "[B]uffer: [D]elete Buffers to the [L]eft",
		},
		-- { "[B",                   "<cmd>BufferLineMovePrev<cr>",             desc = "[B]uffer: Move buffer to prev" },
		-- { "]B",                   "<cmd>BufferLineMoveNext<cr>",             desc = "[B]uffer: Move buffer to next" },
		-- { "[b",                   "<cmd>BufferLineCyclePrev<cr>",            desc = "[B]uffer: [P]rev Buffer" },
		-- { "]b",                   "<cmd>BufferLineCycleNext<cr>",            desc = "[B]uffer: [N]ext Buffer" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "[B]uffer: [P]rev Buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "[B]uffer: [N]ext Buffer" },
		{ "<localleader><Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "[B]uffer: [N]ext Buffer" },
		{ "<localleader><S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "[B]uffer: [P]revious Buffer" },
		{ "<localleader>bp", "<cmd>BufferLinePick<cr>", desc = "[B]uffer: [P]ick Buffer" },
		{ "<A-[>", "<cmd>BufferLineMovePrev<cr>", desc = "[B]uffer: Move to Prev" },
		{ "<A-]>", "<cmd>BufferLineMoveNext<cr>", desc = "[B]uffer: Move to Next" },
	},
	opts = {
		options = {
			disabled_filetypes = { "alpha", "dashboard" },
			-- 左侧让出 nvim-tree 的位置
			offsets = {
				{
					-- filetype = "NvimTree",
					filetype = "neo-tree",
					-- text = "  NvimTree",
					text = "  NeoTree",
					highlight = "NeoTreeTabActive",
					text_align = "center",
					-- separator = true
				},
				{
					filetype = "snacks_layout_box",
				},
			},
            -- stylua: ignore
            close_command = function(n) Snacks.bufdelete(n) end,
            -- stylua: ignore
            right_mouse_command = function(n) Snacks.bufdelete(n) end,
			diagnostics = "nvim_lsp",
			highlight = {
				underline = true,
				sp = "blue",
			}, -- Optional
			always_show_bufferline = false,
			-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
			--     local s = " "
			--     for e, n in pairs(diagnostics_dict) do
			--         local sym = e == "error" and " "
			--             or (e == "warning" and " " or "")
			--         s = s .. n .. sym
			--     end
			--     return s
			-- end,
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
			-- separator_style = "slope",
			numbers = function(opts)
				return string.format("%s.", opts.lower(opts.ordinal))
			end,
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		-- Fix bufferline when restoring a session
		vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
}
