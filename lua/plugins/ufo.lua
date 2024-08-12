return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "VeryLazy",
		-- event = "BufEnter",
		ft = { "python", "cpp", "c", "markdown", "tex", "lua" },
		keys = { -- If these are added, pressing tab conflicts
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Fold: Open All Fold",
				mode = { "n" },
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Fold: Close All Fold",
				mode = { "n" },
			},
			{
				"zj",
				function()
					require("ufo.action").goNextClosedFold()
				end,
				desc = "Fold: Go Next Closed Fold",
				mode = { "n" },
			},
			{
				"zk",
				function()
					require("ufo.action").goPreviousStartFold()
				end,
				desc = "Fold: Go Previous Closed Fold",
				mode = { "n" },
			},
			{
				"zK",
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						vim.lsp.buf.hover()
					end
				end,
				desc = "Fold: Peek Fold",
				mode = { "n" },
			},
		},
		opts = {
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
				-- return { "lsp", "indent" }
			end,

			open_fold_hl_timeout = 0,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("󰁂 %d lines"):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { "    ", nil })
				-- ===== Style 1 =====
				table.insert(newVirtText, { "", "FoldTag" })
				table.insert(newVirtText, { suffix, "@comment.warning" })
				table.insert(newVirtText, { "", "FoldTag" })
				-- ===== Style 2 =====
				-- table.insert(newVirtText, { suffix, "MoreMsg" })
				-- ===== Style 3 =====
				-- table.insert(newVirtText, { suffix, "ModeMsg" })
				return newVirtText
			end,
		},
		config = function(_, opts)
			require("ufo").setup(opts)
			-- Ensure our ufo foldlevel is set for the buffer
			vim.api.nvim_create_autocmd("BufReadPre", {
				callback = function()
					vim.b.ufo_foldlevel = 0
				end,
			})

			---@param num integer Set the fold level to this number
			local set_buf_foldlevel = function(num)
				vim.b.ufo_foldlevel = num
				require("ufo").closeFoldsWith(num)
			end

			---@param num integer The amount to change the UFO fold level by
			local change_buf_foldlevel_by = function(num)
				local foldlevel = vim.b.ufo_foldlevel or 0
				-- Ensure the foldlevel can't be set negatively
				if foldlevel + num >= 0 then
					foldlevel = foldlevel + num
				else
					foldlevel = 0
				end
				set_buf_foldlevel(foldlevel)
			end
			vim.keymap.set("n", "zm", function()
				local count = vim.v.count
				if count == 0 then
					count = 1
				end
				change_buf_foldlevel_by(-count)
			end, { desc = "Fold More" })
			vim.keymap.set("n", "zr", function()
				local count = vim.v.count
				if count == 0 then
					count = 1
				end
				change_buf_foldlevel_by(count)
			end, { desc = "Fold Less" })
		end,
	},
}
