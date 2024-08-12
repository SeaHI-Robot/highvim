return {
	"HiPhish/rainbow-delimiters.nvim",
	event = "VeryLazy",
	opts = {
		condition = function(bufnr)
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
	submodule = false,
	main = "rainbow-delimiters.setup",
}
