vim.loader.enable()

local opt = vim.opt

-- 行号
opt.number = true
opt.relativenumber = true

-- 没有swap
opt.swapfile = false

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = true
opt.cindent = true

-- 防止包裹
opt.wrap = false

-- 光标
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口出现在右边和下边
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

-- 命令模式补全菜单
opt.wildmenu = true

-- undo file
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.local/share/nvim/undo")

-- exrc
-- opt.exra = true

-- no wrap
opt.wrap = false
-- opt.wrap = true

-- 文件有更改自动读取
opt.autoread = true

-- Buffer settings
vim.b.fileencoding = "utf-8"

-- Treat all numbers as decimal numbers
vim.opt.nrformats = ""

-- 支持从ssh复制/粘贴到系统剪切板，ssh连接时，clipboard必须为空，这样设置就可以
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

-- fold
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- views can only be fully collapsed with the global statusline (suggested by avante.mvim)
vim.opt.laststatus = 3
