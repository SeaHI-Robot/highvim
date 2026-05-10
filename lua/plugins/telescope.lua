return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"matkrin/telescope-spell-errors.nvim",
			config = function()
				require("telescope").load_extension("spell_errors")
			end,
			dependencies = "nvim-telescope/telescope.nvim",
		},
	},
    -- stylua: ignore
	keys = {
		{ "<localleader>fa", "<cmd>h digraphs-default<CR>",        mode = { "n" }, desc = "Find Greek and Other Symbols" },
		{ "<localleader>fA", "<cmd>Telescope autocommands<CR>",    mode = { "n" }, desc = "Find Autocommands" },
        { "<localleader>fb", "<cmd>Telescope buffers<CR>",         mode = { "n" }, desc = "Find Buffers" },
		{ "<localleader>fc", "<cmd>Telescope colorscheme<CR>",     mode = { "n" }, desc = "Find Colorschemes" },
		{ "<localleader>fd", "<cmd>Telescope diagnostics<CR>",     mode = { "n" }, desc = "Find Diagnistics" },
		{ "<localleader>fe", "<cmd>Telescope spell_errors<CR>",    mode = { "n" }, desc = "Find Spell Errors" },
        { "<localleader>ff", "<cmd>Telescope find_files<CR>",      mode = { "n" }, desc = "Find Files" },
		{ "<localleader>fg", "<cmd>Telescope live_grep<CR>",       mode = { "n" }, desc = "Live Grep" },
		{ "<localleader>fH", "<cmd>Telescope help_tags<CR>",       mode = { "n" }, desc = "Find Help Tags" },
		{ "<localleader>fh", "<cmd>Telescope highlights<CR>",      mode = { "n" }, desc = "Find Highlights" },
        -- { "<localleader>fi" }  -- Find icons, implemented in Snacks.nvim
		{ "<localleader>fj", "<cmd>Telescope jumplist<CR>",        mode = { "n" }, desc = "Find Jumplist" },
        -- { "<localleader>fk" }  -- Find keymaps, migrate to Snacks.nvim
        { "<localleader>fm", "<cmd>Telescope man_pages<CR>",       mode = { "n" }, desc = "Find Manpages" },
		{ "<localleader>fr", "<cmd>Telescope oldfiles<CR>",        mode = { "n" }, desc = "Recent Files" },
		{ "<localleader>fv", "<cmd>Telescope vim_options<CR>",     mode = { "n" }, desc = "Find Vim Options" },
		{ "<localleader>fw", "<cmd>Telescope grep_string<CR>",     mode = { "n" }, desc = "Find Word under Cursor" },
		{
			"<localleader>fs",
			"<cmd>Telescope lsp_workspace_symbols<CR>",
			mode = { "n" },
			desc = "Find Lsp Workspace Symbols",
		},
		{
			"<localleader>fS",
			"<cmd>Telescope lsp_document_symbols<CR>",
			mode = { "n" },
			desc = "Find Document Symbols",
		},
		{
			"<localleader>fp",
			function()
				require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
			end,
			mode = { "n" },
			desc = "Find Plugin File",
		},
		{ "<localleader>gf", "<cmd>Telescope git_files<CR>",       mode = { "n" }, desc = "Find Git Files" },
		{ "<localleader>gs", "<cmd>Neotree git_status float<CR>",  mode = { "n" }, desc = "Git Status (Float)" },
		{ "<localleader>gS", "<cmd>Telescope git_status<CR>",      mode = { "n" }, desc = "Git Status (Telescope)" },
	},
	cmd = { "Telescope" },
	optional = true,
	opts = function(_, opts)
		local function flash(prompt_bufnr)
			require("flash").jump({
				pattern = "^",
				label = { after = { 0, 0 } },
				search = {
					mode = "search",
					exclude = {
						function(win)
							return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
						end,
					},
				},
				action = function(match)
					local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
					picker:set_selection(match.pos[1] - 1)
				end,
			})
		end
		local focus_preview = function(prompt_bufnr)
			local action_state = require("telescope.actions.state")
			local picker = action_state.get_current_picker(prompt_bufnr)
			local prompt_win = picker.prompt_win
			local previewer = picker.previewer
			local winid = previewer.state.winid
			local bufnr = previewer.state.bufnr
			vim.keymap.set("n", "<A-w>", function()
				vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
			end, { buffer = bufnr })
			vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
		end

		opts.defaults = {
			prompt_prefix = "   ",
			layout_strategy = "horizontal",
			layout_config = {
				prompt_position = "bottom",
				-- prompt_position = "top",
				-- preview_cutoff = 120,
			},
			-- sorting_strategy = "ascending",
			sorting_strategy = "descending",
			winblend = 0,
			mappings = {
				i = { -- Insert mode mappings
					["<C-j>"] = require("telescope.actions").move_selection_next,
					["<C-k>"] = require("telescope.actions").move_selection_previous,
					["<S-Tab>"] = require("telescope.actions").move_selection_next,
					["<Tab>"] = require("telescope.actions").move_selection_previous,
					["<C-s>"] = "select_vertical",
					["<c-s>"] = flash,
					["<A-j>"] = require("telescope.actions").cycle_history_next,
					["<A-k>"] = require("telescope.actions").cycle_history_prev,
					["<A-p>"] = require("telescope.actions.layout").toggle_preview,
					["<A-w>"] = focus_preview,
				},
				n = { -- Normal mode mappings
					["<A-j>"] = require("telescope.actions").cycle_history_next,
					["<A-k>"] = require("telescope.actions").cycle_history_prev,
					["<C-j>"] = require("telescope.actions").move_selection_next,
					["<C-k>"] = require("telescope.actions").move_selection_previous,
					["<A-p>"] = require("telescope.actions.layout").toggle_preview,
					["<C-p>"] = require("telescope.actions.layout").toggle_preview,
					["<A-w>"] = focus_preview,
					["s"] = flash,
					["q"] = require("telescope.actions").close,
				},
			},
			file_ignore_patterns = {
				"^%.git/",
				"^%.git$",
				"^%.venv/",
				"^%nvim-linux-x86_64/",
			},
			-- border = true,
			borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
			color_devicons = true,
		}
		opts.extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		}
	end,

	config = true,
}
