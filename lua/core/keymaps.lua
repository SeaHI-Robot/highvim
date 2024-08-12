vim.g.mapleader = " "
vim.g.maplocalleader = " "
local F = require("core.utils")

-- ---- Normal Mode ---- --

-- 添加空行
vim.keymap.set("n", "<A-o>", "o<ESC>", { noremap = true })
vim.keymap.set("n", "<A-O>", "O<ESC>", { noremap = true })

-- 取消高亮
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- \对应$
vim.keymap.set({ "n", "v" }, "\\", "$", { noremap = true })

-- -对应^
vim.keymap.set({ "n", "v" }, "^", "-", { noremap = true })

-- -对应^
vim.keymap.set({ "n", "v" }, "-", "^", { noremap = true })

-- 删除不复制到剪贴板
vim.keymap.set("n", "x", '"_x', { noremap = true })
-- vim.keymap.set('n', 'D', '"_D', { noremap = true })
-- vim.keymap.set('n', 'd', '"_d', { noremap = true })

-- 查找替换 <Deprecated>
-- vim.keymap.set("n", '<localleader>s', ':%s///g', { noremap = true })

-- 快速打开命令行
vim.keymap.set("n", "<localleader>;", ":", { noremap = true, desc = "Open Command Line" })

-- 快速改变缩进
vim.keymap.set("n", "<", "<<", { noremap = true })
vim.keymap.set("n", ">", ">>", { noremap = true })

-- 全选 & 全选复制
vim.keymap.set("n", "<A-a>", function()
	vim.api.nvim_command("normal! ggVG")
end, { noremap = true })
vim.keymap.set("n", "<A-y>", function()
	vim.api.nvim_command("normal! ggVG$y")
end, { noremap = true })

-- 保存 & Format on Save
-- vim.keymap.set({ "n", "i", "x", "s" }, "<A-s>", function()
--     local filetype = vim.bo.filetype
--     if filetype == "python" then
--         -- ===== Format Using black-macchiato. Need to install: pip install black-macchiato =====
--         -- vim.api.nvim_feedkeys("ggVG", "n", true)
--         -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":", true, false, true), "n", true)
--         -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("!python -m macchiato", true, false, true), "n", true)
--         -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
--         -- vim.api.nvim_feedkeys("<C-o>", "n", true)
--         -- ===== Format using black in terminal =====
--         vim.cmd("!black --line-length 120 --preview %")
--     elseif filetype == "lua" then
--         vim.cmd("!stylua --column-width 120 %")
--     elseif filetype ~= "markdown" then
--         vim.lsp.buf.format({
--             async = false,
--         })
--     end
--     vim.notify("Saved & Formatted !", vim.log.levels.INFO, { title = "Formatter" })
--     vim.cmd("w")
-- end, { noremap = true, desc = "Format and Save File" })
vim.keymap.set({ "n", "i", "x", "s" }, "<C-s>", function()
	vim.cmd("w")
end, { noremap = true, desc = "Save File" })

-- format and code check
vim.keymap.set("n", "<localleader>F", function()
	local filetype = vim.bo.filetype
	if filetype == "python" then
		-- ===== Format Using black-macchiato. Need to install: pip install black-macchiato =====
		-- vim.api.nvim_feedkeys("ggVG", "n", true)
		-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":", true, false, true), "n", true)
		-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("!python -m macchiato", true, false, true), "n",
		--     true)
		-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
		-- vim.api.nvim_feedkeys("<C-o>", "n", true)
		-- ===== Format using black in terminal =====
		vim.cmd("!black --line-length 120 --preview %")
	elseif filetype == "lua" then
		vim.cmd("!stylua --column-width 120 %")
	elseif filetype ~= "markdown" then
		vim.lsp.buf.format({
			async = true,
		})
	end
	vim.notify("File Formatted !", vim.log.levels.INFO, { title = "Formatter" })
end, { noremap = true, desc = "[F]ormat Code" })
vim.keymap.set("n", "<localleader>cC", function()
	local filetype = vim.bo.filetype
	if filetype == "python" then
		vim.cmd("!flake8 %")
	end
	-- vim.notify("File Formatted !", vim.log.levels.INFO, { title = "Formatter" })
end, { noremap = true, desc = "[C]ode [C]heck" })

-- 切换显示行号 -- implemented in lua/plugins/snacks.lua
-- vim.keymap.set("n", "<localleader>n", ":set invnumber<CR>", { noremap = true })
-- vim.keymap.set("n", "<localleader>N", ":set invrelativenumber<CR>", { noremap = true })

-- 改变窗口大小
vim.keymap.set("n", "<S-Left>", function()
	F.smart_resize("left", "small")
end, { desc = "Window Resize Left", noremap = true, silent = true })
vim.keymap.set("n", "<S-Right>", function()
	F.smart_resize("right", "small")
end, { desc = "Window Resize Right", noremap = true, silent = true })
vim.keymap.set("n", "<S-Up>", function()
	F.smart_resize("up", "small")
end, { desc = "Window Resize Up", noremap = true, silent = true })
vim.keymap.set("n", "<S-Down>", function()
	F.smart_resize("down", "small")
end, { desc = "Window Resize Down", noremap = true, silent = true })
vim.keymap.set("n", "<localleader>H", function()
	F.smart_resize("left", "big")
end, { desc = "Window Resize Left", noremap = true, silent = true })
vim.keymap.set("n", "<localleader>L", function()
	F.smart_resize("right", "big")
end, { desc = "Window Resize Right", noremap = true, silent = true })
vim.keymap.set("n", "<localleader>K", function()
	F.smart_resize("up", "big")
end, { desc = "Window Resize Up", noremap = true, silent = true })
vim.keymap.set("n", "<localleader>J", function()
	F.smart_resize("down", "big")
end, { desc = "Window Resize Down", noremap = true, silent = true })

-- Split window on the right
vim.keymap.set("n", "<localleader>\\", "<C-W>v", { noremap = true, desc = "Split Window Right" })
-- Split window on below
vim.keymap.set("n", "<localleader>-", "<C-W>s", { noremap = true, desc = "Split Window Below" })

-- 用 <localleader> + w 代替 ctrl+ w
vim.keymap.set("n", "<localleader>w", "<C-W>", { noremap = true, desc = "Switch Buffer" })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go to Left Window", noremap = true })
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go to Right Window", noremap = true })
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go to Upper Window", noremap = true })
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go to Lower Window", noremap = true })

-- 关闭buffer
vim.keymap.set("n", "<localleader>bc", function()
	Snacks.bufdelete()
end, { noremap = true, desc = "Delete Buffer" })
vim.keymap.set("n", "<localleader>bq", "<cmd>q<CR>", { noremap = true, desc = "Close Window" })

-- 方便浏览代码
vim.keymap.set("n", "<A-;>", "jzz", { noremap = true })
vim.keymap.set("n", "<A-'>", "kzz", { noremap = true })

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down", noremap = true })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up", noremap = true })

-- Move words in line
vim.keymap.set("n", "<A-l>", "xp", { noremap = true, desc = "Move the Selected Right" })
vim.keymap.set("n", "<A-h>", "x2hp", { noremap = true, desc = "Move the Selected Left" })

-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below", noremap = true })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above", noremap = true })

-- Better Subsititution
vim.keymap.set({ "n", "v" }, "<localleader>ss", function()
	local title = " Replace in Current Line "
	F.replace_word_under_cursor(1, tostring(title))
end, { noremap = true, desc = "[S]ubsititute: Replace Word for this Line" })

vim.keymap.set({ "n", "v" }, "<localleader>sc", function()
	local title = " Replace & Confirm in Current Line "
	F.replace_word_under_cursor(2, tostring(title))
end, { noremap = true, desc = "[S]ubsititute: Replace Word for this Line with Confirmation" })

vim.keymap.set({ "n", "v" }, "<localleader>Ss", function()
	local title = " Replace Globally "
	F.replace_word_under_cursor(3, tostring(title))
end, { noremap = true, desc = "[S]ubsititute: Replace Word Globally" })

vim.keymap.set({ "n", "v" }, "<localleader>Sc", function()
	local title = " Replace & Confirm Globally "
	F.replace_word_under_cursor(4, tostring(title))
end, { noremap = true, desc = "[S]ubsititute: Replace Word Globally with Confirmation" })

-- 打印当前buffer文件路径
vim.api.nvim_set_keymap(
	"n",
	"<localleader>pwd",
	"<cmd>echo expand('%:p')<CR>",
	{ noremap = true, desc = "[PWD]: Print Working Directory of Current Buffer" }
)

vim.api.nvim_set_keymap(
	"n",
	"<localleader>pf",
	"<cmd>:echo &filetype<CR>",
	{ noremap = true, desc = "[Print]: Print Filetype" }
)

vim.api.nvim_set_keymap(
	"n",
	"<localleader>pb",
	"<cmd>:echo &buftype<CR>",
	{ noremap = true, desc = "[Print]: Print Buftype" }
)

vim.api.nvim_set_keymap(
	"n",
	"<localleader>cd",
	"<cmd>cd %:p:h<CR> :pwd<CR>",
	{ noremap = true, desc = "[CD]: Change Working Directory to where Current Buffer is" }
)

-- ---- Visual Mode ---- --
-- Move lines
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move the Selected Down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move the Selected Up" })

-- Move words in line
vim.keymap.set("v", "<A-l>", "xp", { noremap = true, desc = "Move the Selected Right" })
vim.keymap.set("v", "<A-h>", "x2hp", { noremap = true, desc = "Move the Selected Left" })

-- 删除和粘贴时不覆盖剪贴板内容
-- vim.keymap.set('v', 'd', '"_d', { noremap = true })
vim.keymap.set("v", "p", '"_dP', { noremap = true })

-- ---- Insert Mode ---- --
-- vim.keymap.set("i", "jf", "<ESC>", { noremap = false })

-- vim.keymap.set("i", "{", "{}<ESC>i", { noremap = true })
-- vim.keymap.set("i", "(", "()<ESC>i", { noremap = true })
-- vim.keymap.set("i", "[", "[]<ESC>i", { noremap = true })
-- vim.keymap.set("i", "\'", "\'\'<ESC>i", { noremap = true })
-- vim.keymap.set("i", "\"", "\"\"<ESC>i", { noremap = true })
-- vim.keymap.set("i", "<", "<><ESC>i", { noremap = true })
vim.keymap.set("i", "<A-j>", "<down>", { noremap = true })
vim.keymap.set("i", "<A-k>", "<up>", { noremap = true })
vim.keymap.set("i", "<A-h>", "<left>", { noremap = true })
vim.keymap.set("i", "<A-l>", "<right>", { noremap = true })
vim.keymap.set("i", "<A-a>", "<home>", { noremap = true })
vim.keymap.set("i", "<A-e>", "<end>", { noremap = true })
-- vim.keymap.set("i", "<A-d>", "<delete>", { noremap = true }) <Conflict with Gnome Terminal keybinds>

vim.keymap.set("i", "<C-j>", "<down>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<up>", { noremap = true })
vim.keymap.set("i", "<C-h>", "<left>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<right>", { noremap = true })
vim.keymap.set("i", "<C-a>", "<home>", { noremap = true })
vim.keymap.set("i", "<C-e>", "<end>", { noremap = true })
vim.keymap.set("i", "<C-d>", "<delete>", { noremap = true })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- ---- Cmd Mode---- --
vim.keymap.set("c", "<C-j>", "<down>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<up>", { noremap = true })
vim.keymap.set("c", "<C-b>", "<left>", { noremap = true })
vim.keymap.set("c", "<C-f>", "<right>", { noremap = true })
vim.keymap.set("c", "<C-a>", "<home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<end>", { noremap = true })
-- vim.keymap.set("c", "<C-d>", "<delete>", { noremap = true }) <Conflict with Gnome Terminal keybinds>

-- ---- Terminal Mode ---- --
-- vim.keymap.set("t", "jf", "<c-\\><c-n>", { desc = "Quit Terminal Mode and Enter Normal Mode", noremap = false })
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Quit Terminal Mode and Enter Normal Mode", noremap = true })
-- vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window", noremap = true })
-- vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window", noremap = true })
-- vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window", noremap = true })
-- vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window", noremap = true })
-- vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal", noremap = true })
-- vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore", noremap = true })
vim.keymap.set(
	"t",
	"<C-w>",
	"<C-\\><C-n><C-w>",
	{ desc = "Quick Window Operation Keymap in Terminal Mode", noremap = true }
)

-- minimize terminal split
vim.keymap.set("n", "<C-g>", F.minimize_terminal_height, { desc = "Minimize Terminal Split", noremap = true })

-- ---- Others ---- --
-- better indenting
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

-- quit
vim.keymap.set({ "n", "v" }, "<localleader>q", "<cmd>qa<cr>", { desc = "Quit All", noremap = true })
vim.keymap.set({ "n", "v" }, "<localleader>fq", "<cmd>q!<cr>", { desc = "Force Quit", noremap = true })
vim.keymap.set({ "n", "v" }, "<localleader>wq", "<cmd>wq<cr>", { desc = "Save and Quit", noremap = true })

vim.keymap.set("n", "<localleader>r", F.Run, { desc = "Run Current File", noremap = true })

-- -----Markdown----- --
-- 使用pandoc渲染markdown成pdf, 和预览pdf
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- 在Markdown模式下设置keymap
		vim.keymap.set("n", "<localleader>pz", function()
			vim.notify("Successfully Exported PDF !", vim.log.levels.INFO, { title = "Pandoc" })
			vim.cmd('!pandoc % --pdf-engine=xelatex -V CJKmainfont="SimSun" --template=eisvogel --listings -o %:r.pdf')
		end, { noremap = true, silent = false })
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- 在Markdown模式下设置keymap
		vim.keymap.set("n", "<localleader>pv", function()
			vim.notify("View Rendered PDF", vim.log.levels.INFO, { title = "Zathura" })
			vim.cmd("!zathura %:r.pdf &disown")
		end, { noremap = true, silent = true })
	end,
})

-- image paste
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = 'markdown',
--     callback = function()
--         -- 在Markdown模式下设置keymap
--         vim.keymap.set({ 'n', 'i' }, '<C-v>', '<cmd>call mdip#MarkdownClipboardImage()<CR>', { noremap = true })
--     end,
-- })

-- md-img-paste插件的配置在neovim中有bug，放在这里可以正常使用
local md_img_name = vim.fn.fnamemodify(vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), ":t:r")
local md_img_dir = "assets." .. md_img_name
vim.g.mdip_imgdir = md_img_dir
-- vim.g.mdip_imgname = 'image'
