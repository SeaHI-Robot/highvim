-- local markdown_preview_theme = "catppuccin" -- github, everforest, gruvbox-material, solarized
local markdown_preview_theme = "everforest"
local markdown_preview_header_position = "bottom" -- top or bottom

if markdown_preview_header_position ~= "top" and markdown_preview_header_position ~= "bottom" then
	error("markdown_preview_header_position must be 'top' or 'bottom'")
end

-- Patch the legacy web bundle without pulling in its old Next.js toolchain.
local function patch_markdown_preview_webui(plugin_dir)
	local function replace_once(path, before, after)
		local input = assert(io.open(path, "rb"))
		local content = input:read("*a")
		input:close()

		if content:find(after, 1, true) then
			return true
		end

		local first, last = content:find(before, 1, true)
		if not first then
			return false
		end

		local output = assert(io.open(path, "wb"))
		output:write(content:sub(1, first - 1), after, content:sub(last + 1))
		output:close()
		return true
	end

	local function replace_any_once(path, candidates, after)
		local input = assert(io.open(path, "rb"))
		local content = input:read("*a")
		input:close()

		if content:find(after, 1, true) then
			return true
		end

		for _, before in ipairs(candidates) do
			local first, last = content:find(before, 1, true)
			if first then
				local output = assert(io.open(path, "wb"))
				output:write(content:sub(1, first - 1), after, content:sub(last + 1))
				output:close()
				return true
			end
		end

		return false
	end

	local function replace_all_once(path, before, after)
		local input = assert(io.open(path, "rb"))
		local original = input:read("*a")
		input:close()

		if original:find(after, 1, true) and not original:find(before, 1, true) then
			return true
		end

		local content = original
		local cursor = 1
		while true do
			local first, last = content:find(before, cursor, true)
			if not first then
				break
			end
			content = content:sub(1, first - 1) .. after .. content:sub(last + 1)
			cursor = first + #after
		end

		if content == original then
			return false
		end

		local output = assert(io.open(path, "wb"))
		output:write(content)
		output:close()
		return true
	end

	local function copy_if_changed(source_path, target_path)
		local source = assert(io.open(source_path, "rb"))
		local content = source:read("*a")
		source:close()

		local target = io.open(target_path, "rb")
		if target then
			local installed = target:read("*a")
			target:close()
			if installed == content then
				return
			end
		end

		local output = assert(io.open(target_path, "wb"))
		output:write(content)
		output:close()
	end

	local function ensure_before_once(path, marker, snippet)
		local input = assert(io.open(path, "rb"))
		local original = input:read("*a")
		input:close()

		local parts = {}
		local cursor = 1
		while true do
			local first, last = original:find(snippet, cursor, true)
			if not first then
				table.insert(parts, original:sub(cursor))
				break
			end
			table.insert(parts, original:sub(cursor, first - 1))
			cursor = last + 1
		end

		local content = table.concat(parts)
		local first = content:find(marker, 1, true)
		if not first then
			return false
		end

		local updated = content:sub(1, first - 1) .. snippet .. content:sub(first)
		if updated ~= original then
			local output = assert(io.open(path, "wb"))
			output:write(updated)
			output:close()
		end
		return true
	end

	local function remove_all(path, snippet)
		local input = assert(io.open(path, "rb"))
		local original = input:read("*a")
		input:close()

		local parts = {}
		local cursor = 1
		while true do
			local first, last = original:find(snippet, cursor, true)
			if not first then
				table.insert(parts, original:sub(cursor))
				break
			end
			table.insert(parts, original:sub(cursor, first - 1))
			cursor = last + 1
		end

		local updated = table.concat(parts)
		if updated ~= original then
			local output = assert(io.open(path, "wb"))
			output:write(updated)
			output:close()
		end
		return true
	end

	local source_ok = replace_once(
		vim.fs.joinpath(plugin_dir, "app", "pages", "index.jsx"),
		"window.history.replaceState(null, '', `/${bufnr}`)",
		"window.history.replaceState(null, '', `/page/${bufnr}`)"
	)
	local sync_source_ok = replace_once(
		vim.fs.joinpath(plugin_dir, "app", "pages", "index.jsx"),
		"if (isActive && !options.disable_sync_scroll) {",
		"if (window.mkdpAutoSync !== false && isActive && !options.disable_sync_scroll) {"
	)
	local theme_source_initial_ok = replace_once(
		vim.fs.joinpath(plugin_dir, "app", "pages", "index.jsx"),
		"themeModeIsVisible: false,",
		"themeModeIsVisible: true,"
	)
	local theme_source_hide_ok = replace_once(
		vim.fs.joinpath(plugin_dir, "app", "pages", "index.jsx"),
		"hideThemeButton() {\n    this.setState({ themeModeIsVisible: false })\n  }",
		"hideThemeButton() {\n    this.setState({ themeModeIsVisible: true })\n  }"
	)
	local theme_source_toggle_ok = replace_once(
		vim.fs.joinpath(plugin_dir, "app", "pages", "index.jsx"),
		"theme: state.theme === 'light' ? 'dark' : 'light',",
		"theme: state.theme === 'dark' ? 'light' : 'dark',"
	)
	local keep_open_source_ok = replace_once(
		vim.fs.joinpath(plugin_dir, "app", "pages", "index.jsx"),
		"onClose() {\n    console.log('close')\n    window.close()\n  }",
		"onClose() {\n    if (window.mkdpKeepOpen === true) return\n    console.log('close')\n    window.close()\n  }"
	)
	local favicon_source_ok = replace_any_once(
		vim.fs.joinpath(plugin_dir, "app", "pages", "index.jsx"),
		{
			'<link rel="shortcut icon" type="image/ico" href="/_static/favicon.ico" />',
			'<link rel="icon" type="image/svg+xml" href="/_static/highvim-favicon.svg?v=2" />',
		},
		'<link rel="icon" type="image/x-icon" href="/_static/highvim-favicon.ico?v=4" />'
	)

	local url_bundle_ok = false
	local sync_bundle_ok = false
	local theme_bundle_initial_ok = false
	local theme_bundle_hide_ok = false
	local theme_bundle_toggle_ok = false
	local keep_open_bundle_ok = false
	local favicon_bundle_ok = false
	local bundle_pattern = vim.fs.joinpath(plugin_dir, "app", "out", "_next", "static", "*", "pages", "index.js")
	for _, bundle in ipairs(vim.fn.glob(bundle_pattern, false, true)) do
		url_bundle_ok = replace_once(
			bundle,
			'window.history.replaceState(null,"","/".concat(e))',
			'window.history.replaceState(null,"","/page/".concat(e))'
		) or url_bundle_ok
		sync_bundle_ok = replace_once(
			bundle,
			"i&&!a.disable_sync_scroll&&se[",
			"window.mkdpAutoSync!==!1&&i&&!a.disable_sync_scroll&&se["
		) or sync_bundle_ok
		theme_bundle_initial_ok = replace_once(
			bundle,
			"themeModeIsVisible:!1,contentEditable",
			"themeModeIsVisible:!0,contentEditable"
		) or theme_bundle_initial_ok
		theme_bundle_hide_ok = replace_once(
			bundle,
			'hideThemeButton",value:function(){this.setState({themeModeIsVisible:!1})}',
			'hideThemeButton",value:function(){this.setState({themeModeIsVisible:!0})}'
		) or theme_bundle_hide_ok
		theme_bundle_toggle_ok = replace_once(
			bundle,
			'theme:"light"===e.theme?"dark":"light"',
			'theme:"dark"===e.theme?"light":"dark"'
		) or theme_bundle_toggle_ok
		keep_open_bundle_ok = replace_once(
			bundle,
			'onClose",value:function(){console.log("close"),window.close()}',
			'onClose",value:function(){if(window.mkdpKeepOpen===!0)return;console.log("close"),window.close()}'
		) or keep_open_bundle_ok
		favicon_bundle_ok = replace_any_once(
			bundle,
			{
				'rel:"shortcut icon",type:"image/ico",href:"/_static/favicon.ico"',
				'rel:"icon",type:"image/svg+xml",href:"/_static/highvim-favicon.svg?v=2"',
			},
			'rel:"icon",type:"image/x-icon",href:"/_static/highvim-favicon.ico?v=4"'
		) or favicon_bundle_ok
	end

	local index_path = vim.fs.joinpath(plugin_dir, "app", "out", "index.html")
	local bundle_cache_ok = replace_all_once(
		index_path,
		'/pages/index.js"',
		'/pages/index.js?highvim=theme2"'
	)
	local favicon_html_ok = replace_any_once(
		index_path,
		{
			'<link rel="shortcut icon" type="image/ico" href="/_static/favicon.ico" class="next-head"/>',
			'<link rel="icon" type="image/svg+xml" href="/_static/highvim-favicon.svg?v=2" class="next-head"/>',
		},
		'<link rel="icon" type="image/x-icon" href="/_static/highvim-favicon.ico?v=4" class="next-head"/>'
	)
	local legacy_style_removed = remove_all(
		index_path,
		'<link rel="stylesheet" href="/_static/highvim-controls.css">'
	)
	local cached_style_removed = remove_all(
		index_path,
		'<link rel="stylesheet" href="/_static/highvim-controls.css?v=2">'
	)
	local previous_style_removed = remove_all(
		index_path,
		'<link rel="stylesheet" href="/_static/highvim-controls.css?v=3">'
	)
	local current_style_removed = remove_all(
		index_path,
		'<link rel="stylesheet" href="/_static/highvim-controls.css?v=5">'
	)
	local previous_current_style_removed = remove_all(
		index_path,
		'<link rel="stylesheet" href="/_static/highvim-controls.css?v=6">'
	)
	local latest_style_removed = remove_all(
		index_path,
		'<link rel="stylesheet" href="/_static/highvim-controls.css?v=7">'
	)
	local compact_header_style_removed = remove_all(
		index_path,
		'<link rel="stylesheet" href="/_static/highvim-controls.css?v=8">'
	)
	local detached_handles_style_removed = remove_all(
		index_path,
		'<link rel="stylesheet" href="/_static/highvim-controls.css?v=9">'
	)
	local style_ok = ensure_before_once(
		index_path,
		"</head>",
		'<link rel="stylesheet" href="/_static/highvim-controls.css?v=10">'
	)
	local injected_favicon_removed = remove_all(
		index_path,
		'<link id="highvim-favicon" rel="icon" type="image/svg+xml" href="/_static/highvim-favicon.svg?v=1">'
	)
	local legacy_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js"></script>'
	)
	local cached_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js?v=2"></script>'
	)
	local previous_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js?v=3"></script>'
	)
	local current_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js?v=4"></script>'
	)
	local current_ui_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js?v=5"></script>'
	)
	local resize_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js?v=6"></script>'
	)
	local header_position_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js?v=7"></script>'
	)
	local compact_header_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js?v=8"></script>'
	)
	local detached_handles_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js?v=9"></script>'
	)
	local header_handles_script_removed = remove_all(
		index_path,
		'<script defer src="/_static/highvim-controls.js?v=10"></script>'
	)
	local top_position_removed = remove_all(
		index_path,
		'<script>window.mkdpHeaderPosition="top"</script>'
	)
	local bottom_position_removed = remove_all(
		index_path,
		'<script>window.mkdpHeaderPosition="bottom"</script>'
	)
	local header_position_ok = ensure_before_once(
		index_path,
		"</body>",
		'<script>window.mkdpHeaderPosition="' .. markdown_preview_header_position .. '"</script>'
	)
	local script_ok = ensure_before_once(
		index_path,
		"</body>",
		'<script defer src="/_static/highvim-controls.js?v=11"></script>'
	)

	local webui_assets = vim.fs.joinpath(vim.fn.stdpath("config"), "assets", "markdown-preview", "webui")
	local static_dir = vim.fs.joinpath(plugin_dir, "app", "_static")
	copy_if_changed(
		vim.fs.joinpath(webui_assets, "controls.css"),
		vim.fs.joinpath(static_dir, "highvim-controls.css")
	)
	copy_if_changed(
		vim.fs.joinpath(webui_assets, "controls.js"),
		vim.fs.joinpath(static_dir, "highvim-controls.js")
	)
	copy_if_changed(
		vim.fs.joinpath(webui_assets, "favicon.ico"),
		vim.fs.joinpath(static_dir, "highvim-favicon.ico")
	)
	copy_if_changed(
		vim.fs.joinpath(webui_assets, "favicon.ico"),
		vim.fs.joinpath(static_dir, "favicon.ico")
	)

	if
		not source_ok
		or not sync_source_ok
		or not theme_source_initial_ok
		or not theme_source_hide_ok
		or not theme_source_toggle_ok
		or not url_bundle_ok
		or not sync_bundle_ok
		or not theme_bundle_initial_ok
		or not theme_bundle_hide_ok
		or not theme_bundle_toggle_ok
		or not bundle_cache_ok
		or not keep_open_source_ok
		or not keep_open_bundle_ok
		or not favicon_source_ok
		or not favicon_bundle_ok
		or not favicon_html_ok
		or not injected_favicon_removed
		or not legacy_style_removed
		or not cached_style_removed
		or not previous_style_removed
		or not current_style_removed
		or not previous_current_style_removed
		or not latest_style_removed
		or not compact_header_style_removed
		or not detached_handles_style_removed
		or not legacy_script_removed
		or not cached_script_removed
		or not previous_script_removed
		or not current_script_removed
		or not current_ui_script_removed
		or not resize_script_removed
		or not header_position_script_removed
		or not compact_header_script_removed
		or not detached_handles_script_removed
		or not header_handles_script_removed
		or not top_position_removed
		or not bottom_position_removed
		or not header_position_ok
		or not style_ok
		or not script_ok
	then
		error("markdown-preview.nvim Web UI patch no longer matches the installed plugin")
	end
end

return {
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
		build = "cd app && yarn install",
		-- build = function(plugin)
		--     if vim.fn.executable "npx" then
		--         vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
		--     else
		--         vim.cmd [[Lazy load markdown-preview.nvim]]
		--         vim.fn["mkdp#util#install"]()
		--     end
		-- end,
		config = function(plugin)
			patch_markdown_preview_webui(plugin.dir)
		end,
		init = function()
			local preview_assets = vim.fs.joinpath(
				vim.fn.stdpath("config"),
				"assets",
				"markdown-preview",
				markdown_preview_theme
			)
			vim.g.mkdp_markdown_css = vim.fs.joinpath(preview_assets, "markdown.css")
			vim.g.mkdp_highlight_css = vim.fs.joinpath(preview_assets, "highlight.css")
			vim.g.mkdp_refresh_slow = 0

			if vim.fn.executable("npx") then
				vim.g.mkdp_filetypes = { "markdown" }
			end
			local function mkdp_command(name, fn_name)
				vim.api.nvim_create_user_command(name, function()
					require("lazy").load({ plugins = { "markdown-preview.nvim" } })
					vim.fn["mkdp#util#" .. fn_name]()
				end, { force = true })
			end
			mkdp_command("MarkdownPreview", "open_preview_page")
			mkdp_command("MarkdownPreviewStop", "stop_preview")
			mkdp_command("MarkdownPreviewToggle", "toggle_preview")
		end,
	},
	{
		"Kicamon/markdown-table-mode.nvim",
		ft = { "markdown", "quarto" },
		cmd = "Mtm",
		opts = {
			filetype = {
				"*.md",
				"*.qmd",
			},
			options = {
				insert = true, -- when typing "|"
				insert_leave = true, -- when leaving insert
				pad_separator_line = false, -- add space in separator line
				alig_style = "default", -- default, left, center, right
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			-- {
			--     "jbyuki/nabla.nvim",
			--     ft = { "markdown", "Avante" },
			--     keys = {
			--         {
			--             "K",
			--             '<cmd>lua require("nabla").popup()<cr>',
			--             desc = "Preview Latex Formula in markdown",
			--             mode = "n",
			--         },
			--     },
			-- },
		}, -- if you prefer nvim-web-devicons
		ft = { "markdown", "Avante", "llm" },
		opts = {
			latex = {
				enabled = true,
				render_modes = false,
				converter = "latex2text",
				highlight = "RenderMarkdownMath",
				position = "above",
				top_pad = 0,
				bottom_pad = 0,
			},
			win_options = { conceallevel = { rendered = 2 } },
			-- -- nabla configuration (I don't like nabla's render result)
			-- on = {
			--     render = function()
			--         require("nabla").enable_virt({ autogen = true })
			--     end,
			--     clear = function()
			--         require("nabla").disable_virt()
			--     end,
			-- },
			file_types = { "markdown", "Avante", "llm" },
			completions = {
				lsp = { enabled = true },
				completions = { blink = { enabled = true } }, -- enable for blink.cmp
			},
			callout = { -- callout works for github markdown render: https://docs.github.com/zh/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts
				note = {
					raw = "[!NOTE]",
					rendered = "󰋽 Note",
					highlight = "RenderMarkdownInfo",
					category = "github",
				},
				tip = {
					raw = "[!TIP]",
					rendered = "󰌶 Tip",
					highlight = "RenderMarkdownSuccess",
					category = "github",
				},
				important = {
					raw = "[!IMPORTANT]",
					rendered = "󰅾 Important",
					highlight = "RenderMarkdownHint",
					category = "github",
				},
				warning = {
					raw = "[!WARNING]",
					rendered = "󰀪 Warning",
					highlight = "RenderMarkdownWarn",
					category = "github",
				},
				caution = {
					raw = "[!CAUTION]",
					rendered = "󰳦 Caution",
					highlight = "RenderMarkdownError",
					category = "github",
				},
				abstract = {
					raw = "[!ABSTRACT]",
					rendered = "󰨸 Abstract",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				summary = {
					raw = "[!SUMMARY]",
					rendered = "󰨸 Summary",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				tldr = {
					raw = "[!TLDR]",
					rendered = "󰨸 Tldr",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				info = {
					raw = "[!INFO]",
					rendered = "󰋽 Info",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				todo = {
					raw = "[!TODO]",
					rendered = "󰗡 Todo",
					highlight = "RenderMarkdownInfo",
					category = "obsidian",
				},
				hint = {
					raw = "[!HINT]",
					rendered = "󰌶 Hint",
					highlight = "RenderMarkdownSuccess",
					category = "obsidian",
				},
				success = {
					raw = "[!SUCCESS]",
					rendered = "󰄬 Success",
					highlight = "RenderMarkdownSuccess",
					category = "obsidian",
				},
				check = {
					raw = "[!CHECK]",
					rendered = "󰄬 Check",
					highlight = "RenderMarkdownSuccess",
					category = "obsidian",
				},
				done = {
					raw = "[!DONE]",
					rendered = "󰄬 Done",
					highlight = "RenderMarkdownSuccess",
					category = "obsidian",
				},
				question = {
					raw = "[!QUESTION]",
					rendered = "󰘥 Question",
					highlight = "RenderMarkdownWarn",
					category = "obsidian",
				},
				help = {
					raw = "[!HELP]",
					rendered = "󰘥 Help",
					highlight = "RenderMarkdownWarn",
					category = "obsidian",
				},
				faq = {
					raw = "[!FAQ]",
					rendered = "󰘥 Faq",
					highlight = "RenderMarkdownWarn",
					category = "obsidian",
				},
				attention = {
					raw = "[!ATTENTION]",
					rendered = "󰀪 Attention",
					highlight = "RenderMarkdownWarn",
					category = "obsidian",
				},
				failure = {
					raw = "[!FAILURE]",
					rendered = "󰅖 Failure",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				fail = {
					raw = "[!FAIL]",
					rendered = "󰅖 Fail",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				missing = {
					raw = "[!MISSING]",
					rendered = "󰅖 Missing",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				danger = {
					raw = "[!DANGER]",
					rendered = "󱐌 Danger",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				error = {
					raw = "[!ERROR]",
					rendered = "󱐌 Error",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				bug = {
					raw = "[!BUG]",
					rendered = "󰨰 Bug",
					highlight = "RenderMarkdownError",
					category = "obsidian",
				},
				example = {
					raw = "[!EXAMPLE]",
					rendered = "󰉹 Example",
					highlight = "RenderMarkdownHint",
					category = "obsidian",
				},
				quote = {
					raw = "[!QUOTE]",
					rendered = "󱆨 Quote",
					highlight = "RenderMarkdownQuote",
					category = "obsidian",
				},
				cite = {
					raw = "[!CITE]",
					rendered = "󱆨 Cite",
					highlight = "RenderMarkdownQuote",
					category = "obsidian",
				},
			},
		},
	},
	-- {
	--     -- support for image pasting
	--     "HakonHarnes/img-clip.nvim",
	--     event = "VeryLazy",
	--     opts = {
	--         -- recommended settings
	--         default = {
	--             embed_image_as_base64 = false,
	--             prompt_for_file_name = false,
	--             drag_and_drop = {
	--                 insert_mode = true,
	--             },
	--             -- required for Windows users
	--             use_absolute_path = false,
	--         },
	--         filetypes = {
	--             markdown = {
	--                 url_encode_path = true,
	--                 template = "![$CURSOR]($FILE_PATH)",
	--                 drag_and_drop = {
	--                     download_images = false,
	--                 },
	--             },
	--             quarto = {
	--                 url_encode_path = true,
	--                 template = "![$CURSOR]($FILE_PATH)",
	--                 drag_and_drop = {
	--                     download_images = false,
	--                 },
	--             },
	--         },
	--     },
	--     ft = { "markdown", "Avante", "quarto" },
	--     -- keys = {
	--     --     { "<localleader>i", mode = { "i" }, "<Cmd>PasteImage<CR>", desc = "PasteImage" },
	--     -- },
	-- },
	-- {
	--     "MeanderingProgrammer/markdown.nvim",
	--     main = "render-markdown",
	--     ft = { "markdown" },
	--     -- keys = { -- If these are added, pressing tab conflicts
	--     --     { "<C-i>", "**<left>", desc = "Markdown: Italic", mode = { "i" } },
	--     --     { "<C-b>", "****<left><left>", desc = "Markdown: Bold", mode = { "i" } },
	--     -- },
	--     opts = {},
	--     dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	-- },
	--
}
