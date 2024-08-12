local F = {}

local function is_visual_mode(mode)
	return mode == "v" or mode == "V" or mode == "\x16"
end

-- define utf8 char length
local function utf8_char_length(byte)
	if byte < 0x80 then
		return 1
	elseif byte >= 0xC0 and byte < 0xE0 then
		return 2
	elseif byte >= 0xE0 and byte < 0xF0 then
		return 3
	elseif byte >= 0xF0 then
		return 4
	end
end

local function utf8_sub(s, i, j)
	i = i or 1
	j = j or -1

	local start, stop = i, #s
	local utf8_len, pos = 0, 1

	while pos <= stop do
		local c = s:byte(pos)
		local char_len = utf8_char_length(c)
		utf8_len = utf8_len + char_len
		pos = pos + char_len
		if utf8_len >= j then
			stop = pos - 1
			break
		end
	end
	return s:sub(start, stop)
end

local function GetVisualSelectionRange(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	-- store the current mode
	local mode = vim.fn.mode()
	-- if we're not in visual mode, we need to re-enter it briefly
	local is_visual = is_visual_mode(mode)

	-- Get positions
	local start_pos, end_pos
	if is_visual then
		-- If we're in visual mode, use 'v' and '.'
		start_pos = vim.fn.getpos("v")
		end_pos = vim.fn.getpos(".")
	else
		-- Fallback to marks if not in visual mode
		start_pos = vim.fn.getpos("'<")
		end_pos = vim.fn.getpos("'>")
	end

	local start_line = start_pos[2]
	local start_col = start_pos[3]
	local end_line = end_pos[2]
	local end_col = end_pos[3]

	-- normalize the range to start < end
	if start_line > end_line or (start_line == end_line and start_col > end_col) then
		start_line, end_line = end_line, start_line
		start_col, end_col = end_col, start_col
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

	-- get whole buffer if there is no current/previous visual selection
	if start_line == 0 then
		lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		start_line = 1
		start_col = 0
		end_line = #lines
		end_col = #lines[#lines]
	end

	local n_lines = #lines
	-- Handle partial line selections
	if n_lines > 0 then
		if mode == "V" or (not is_visual and vim.fn.visualmode() == "V") then
			-- For line-wise selection, use full lines
			start_col = 1
			end_col = #lines[#lines]
		else
			-- For character-wise selection, respect the columns
			if n_lines == 1 then
				lines[1] = utf8_sub(lines[1], start_col, end_col)
			else
				lines[1] = utf8_sub(lines[1], start_col, #lines[1])
				if mode == "v" then
					lines[n_lines] = utf8_sub(lines[n_lines], 1, end_col)
				else
					for n = 2, n_lines - 1 do
						lines[n] = utf8_sub(lines[n], start_col, #lines[n])
					end
					lines[n_lines] = utf8_sub(lines[n_lines], start_col, end_col)
				end
			end
		end
	end
	return lines, start_line, start_col, end_line, end_col
end

function F.GetVisualSelection(lines)
	-- Only retrieve the first return parameter of the `GetVisualSelectionRange` function.
	lines = lines or GetVisualSelectionRange()
	local seletion = table.concat(lines, "\n")
	return seletion
end

function F.smart_resize(direction, resize_step)
	local current_win = vim.api.nvim_get_current_win()
	local win_row = vim.api.nvim_win_get_position(current_win)[1]
	local win_col = vim.api.nvim_win_get_position(current_win)[2]
	local step_horizontal = 0
	local step_vertical = 0
	if resize_step == "big" then
		step_horizontal = vim.o.columns / 4
		step_vertical = vim.o.lines / 4
	elseif resize_step == "small" then
		step_horizontal = 5
		step_vertical = 5
	end

	if direction == "left" then
		if win_col == 0 then -- if window on the left
			vim.cmd("vertical resize -" .. step_horizontal)
		else
			vim.cmd("vertical resize +" .. step_horizontal)
		end
	elseif direction == "right" then
		if win_col == 0 then -- if window on the left
			vim.cmd("vertical resize +" .. step_horizontal)
		else
			vim.cmd("vertical resize -" .. step_horizontal)
		end
	elseif direction == "up" then
		if win_row == 0 then -- if window on the top
			vim.cmd("resize -" .. step_vertical)
		else
			vim.cmd("resize +" .. step_vertical)
		end
	elseif direction == "down" then
		if win_row == 0 then -- if window on the top
			vim.cmd("resize +" .. step_vertical)
		else
			vim.cmd("resize -" .. step_vertical)
		end
	end
end

function F.replace_word_under_cursor(flag, window_title)
	local word = ""
	local mode = vim.fn.mode()

	if mode == "n" then
		word = vim.fn.expand("<cword>")
	elseif mode == "v" then
		word = F.GetVisualSelection()
		if word == "" then
			vim.notify("No visual selection found", vim.log.levels.WARN, { title = "Rename" })
			return
		end
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "v", true)
	else
		vim.notify("Invalid mode: " .. mode, vim.log.levels.ERROR, { title = "Rename" })
		return
	end

	local word_width = vim.fn.strwidth(word)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	-- 构造替换命令，并将光标放置在待输入新词的位置
	local Input = require("nui.input")
	local event = require("nui.utils.autocmd").event

	local input = Input({
		enter = false,
		position = {
			row = 2,
			col = 0,
		},
		relative = {
			type = "buf",
			position = {
				row = row - 1,
				col = col,
			},
		},
		size = {
			width = word_width + 30,
			height = 1,
		},
		border = {
			style = "rounded",
			text = {
				top = window_title,
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Comment,FloatBorder:Comment",
		},
	}, {
		prompt = "> ",
		default_value = word,
		on_close = function()
			vim.notify("Rename Quit", vim.log.levels.INFO, { title = string.sub(window_title, 2, -2) })
		end,
		on_submit = function(value)
			-- print("Input Submitted: " .. value)
			if flag == 1 then
				vim.cmd(":s/" .. word .. "/" .. value .. "/g")
			elseif flag == 2 then
				vim.cmd(":s/" .. word .. "/" .. value .. "/gc")
			elseif flag == 3 then
				vim.cmd(":%s/" .. word .. "/" .. value .. "/g")
			elseif flag == 4 then
				vim.cmd(":%s/" .. word .. "/" .. value .. "/gc")
			end
			vim.notify("Rename Done", vim.log.levels.INFO, { title = string.sub(window_title, 2, -2) })
		end,
	})
	local function on_exit()
		input:hide()
		input:unmount()
	end
	-- mount/open the component
	input:mount()

	-- 在输入框打开后，立刻切换到普通模式
	-- vim.cmd('stopinsert') -- 停止插入模式，回到普通模式

	-- bind keys to exit
	input:map("n", "q", on_exit) -- 按下 'q' 键退出
	input:map("n", "<C-c>", on_exit) -- 按下 'q' 键退出
	input:map("n", "<Esc>", on_exit) -- 按下 'Esc' 键退出
	input:map("i", "<C-c>", on_exit) -- 按下 'q' 键退出
	-- input:map('i', '<Esc>', on_exit) -- 按下 'Esc' 键退出

	-- unmount component when cursor leaves buffer
	input:on(event.BufLeave, function()
		input:unmount()
	end)
end

function F.is_toggleterm_opened() -- check if toggleterm terminal is opened
	-- 获取所有窗口
	local windows = vim.api.nvim_list_wins()
	for _, win in ipairs(windows) do
		-- 获取窗口的 buffer
		local buf = vim.api.nvim_win_get_buf(win)
		-- 检查 buffer 名称是否与 ToggleTerm 的 buffer 名称匹配
		local buf_name = vim.api.nvim_buf_get_name(buf)
		if buf_name:match("^term://") then
			return true -- 找到 ToggleTerm 窗口，返回 true
		end
	end
	return false -- 没有找到 ToggleTerm 窗口，返回 false
end

function F.minimize_terminal_height()
	if F.is_toggleterm_opened() then
		local switch_to_toggleterm = vim.api.nvim_replace_termcodes("<C-w>j", true, false, true)
		local minimize_terminal = vim.api.nvim_replace_termcodes("3<C-w>_", true, false, true)
		vim.api.nvim_feedkeys(switch_to_toggleterm, "m", true)
		vim.api.nvim_feedkeys(minimize_terminal, "m", true)
	end
end

function F.Run()
	-- 保存文件
	vim.cmd("w")
	local filetype = vim.bo.filetype

	local file_name = vim.api.nvim_buf_get_name(0)
	local cmd
	local need_term_exec = true

	-- define commands according to filetype
	if filetype == "python" then
		local python3_path = vim.fn.trim(vim.fn.system("which python3"))
		if python3_path ~= "" then
			print("Python3 Path: " .. python3_path)
		else
			print("Not Found Python3 Interpreter! ")
		end
		cmd = python3_path .. ' "' .. file_name .. '"'
	elseif filetype == "lua" then
		cmd = 'lua "' .. file_name .. '"'
	elseif filetype == "markdown" then
		vim.cmd("MarkdownPreviewToggle")
		need_term_exec = false
	elseif filetype == "javascript" then
		cmd = 'node "' .. file_name .. '"'
	elseif filetype == "html" then
		cmd = 'microsoft-edge "' .. file_name .. '"'
	elseif filetype == "c" then
		cmd = 'gcc "' .. file_name .. '" -o "' .. file_name:gsub(".c", "") .. ' && "' .. file_name:gsub(".c", "") .. '"'
	elseif filetype == "cpp" then
		cmd = 'g++ "'
			.. file_name
			.. '" -o "'
			.. file_name:gsub(".cpp", "")
			.. ' && "'
			.. file_name:gsub(".cpp", "")
			.. '"'
	elseif filetype == "matlab" then
		cmd = 'octave "' .. file_name .. '"'
	end

	if need_term_exec then
		if not cmd then
			vim.notify("No run command configured for filetype: " .. filetype, vim.log.levels.WARN, { title = "Run" })
			return
		end

		local terminal_commands = vim.api.nvim_replace_termcodes(cmd, true, false, true)

		if F.is_toggleterm_opened() then
			local switch_to_toggleterm = vim.api.nvim_replace_termcodes("<C-w>j", true, false, true)
			local enter_insert_mode = vim.api.nvim_replace_termcodes("i", true, false, true)
			vim.api.nvim_feedkeys(switch_to_toggleterm, "m", true)
			vim.api.nvim_feedkeys(enter_insert_mode, "m", true)
		else
			vim.cmd("ToggleTerm")
		end
		-- execute terminal commands
		vim.api.nvim_feedkeys(terminal_commands, "t", false)
	end
end

return F
