-- leader为;
vim.g.mapleader = ";"


-- ----Insert---- --
vim.keymap.set("i", "jf", "<ESC>", { noremap = true })
-- vim.keymap.set("i", "{", "{}<ESC>i", { noremap = true })
-- vim.keymap.set("i", "(", "()<ESC>i", { noremap = true })
-- vim.keymap.set("i", "[", "[]<ESC>i", { noremap = true })
-- vim.keymap.set("i", "\'", "\'\'<ESC>i", { noremap = true })
-- vim.keymap.set("i", "\"", "\"\"<ESC>i", { noremap = true })
vim.keymap.set("i", "<", "<><ESC>i", { noremap = true })
vim.keymap.set("i", "<C-j>", "<down>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<up>", { noremap = true })
vim.keymap.set("i", "<C-b>", "<left>", { noremap = true })
vim.keymap.set("i", "<C-f>", "<right>", { noremap = true })
vim.keymap.set("i", "<C-a>", "<home>", { noremap = true })
vim.keymap.set("i", "<C-e>", "<end>", { noremap = true })
vim.keymap.set("i", "<C-d>", "<delete>", { noremap = true })


-- ----Cmd---- --
vim.keymap.set("c", "<C-j>", "<down>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<up>", { noremap = true })
vim.keymap.set("c", "<C-b>", "<left>", { noremap = true })
vim.keymap.set("c", "<C-f>", "<right>", { noremap = true })
vim.keymap.set("c", "<C-a>", "<home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<end>", { noremap = true })
vim.keymap.set("c", "<C-d>", "<delete>", { noremap = true })


-- ----Normal---- --
-- 空格冒号
vim.keymap.set({ "n", "v" }, " ", ":", { noremap = true })

-- 添加空行
vim.keymap.set("n", "<C-l>", "o<ESC>", { noremap = true })

-- 取消高亮
vim.keymap.set("n", "<leader>q", ":nohl<CR>", { noremap = true })

-- \对应$
vim.keymap.set({ "n", "v" }, '\\', '$', { noremap = true })

-- 查找替换
vim.keymap.set("n", '<leader>s', ':%s/old/new/g', { noremap = true })

-- 保存
--vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true })
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<CR>", { noremap = true })

-- 切换显示行号
vim.keymap.set("n", "<leader>n", ":set invnumber<CR>", { noremap = true })
vim.keymap.set("n", "<leader>N", ":set invrelativenumber<CR>", { noremap = true })

-- 改变窗口大小
vim.keymap.set('n', '<S-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Up>', ':resize +2<CR>', { noremap = true })
vim.keymap.set('n', '<S-Down>', ':resize -2<CR>', { noremap = true })

-- 分屏操作
--用 <leader> + v 代替 ctrl+ w 再按 v 进行左右分屏
vim.keymap.set('n', '<leader>v', '<C-W>v', { noremap = true })
--用 <leader> + w 代替 ctrl+ w 再按 w 进行分屏间切换
vim.keymap.set('n', '<leader>w', '<C-W>w', { noremap = true, desc = "Switch Buffer" })
--用 <leader> + h 代替 ctrl+ w 再按 h 进行向左边分屏切换
vim.keymap.set('n', '<leader>h', '<C-W>h', { noremap = true, desc = "Switch to the Left Buffer" })
--用 <leader> + l 代替 ctrl+ w 再按 l 进行向右边分屏切换
vim.keymap.set('n', '<leader>l', '<C-W>l', { noremap = true, desc = "Switch to the Right Buffer" })
--用 <leader> + H 代替 ctrl+ w 再按 H 进行向左边移动
vim.keymap.set('n', '<leader>H', '<C-W>H', { noremap = true })
--用 <leader> + L 代替 ctrl+ w 再按 L 进行向右边移动
vim.keymap.set('n', '<leader>L', '<C-W>L', { noremap = true })
--用 <leader> + j 代替 ctrl+ w 再按 j 进行向下边分屏切换
vim.keymap.set('n', '<leader>j', '<C-W>j', { noremap = true })
--用 <leader> + k 代替 ctrl+ w 再按 k 进行向上边分屏切换
vim.keymap.set('n', '<leader>k', '<C-W>k', { noremap = true })
--用 <leader> + J 代替 ctrl+ w 再按 J 进行向下边移动
vim.keymap.set('n', '<leader>J', '<C-W>J', { noremap = true })
--用 <leader> + K 代替 ctrl+ w 再按 K 进行向上边移动
vim.keymap.set('n', '<leader>K', '<C-W>K', { noremap = true })

-- 切换buffer
vim.keymap.set('n', '<leader><Tab>', "<cmd>bNext<CR>", { noremap = true })

-- 关闭buffer
vim.keymap.set('n', '<C-w>', "<cmd>bdelete<CR>", { noremap = true })

-- 方便浏览代码
vim.keymap.set('n', '<C-j>', "jzz", { noremap = true })
vim.keymap.set('n', '<C-k>', "kzz", { noremap = true })


-- ----visual---- --
-- 整行移动 巨好用
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv", { noremap = true })


-- -----Run----- --
function Run()
    -- 保存文件
    vim.cmd('w')
    local filetype = vim.bo.filetype
    if filetype == 'python' then
        vim.cmd("!python3 %")
    elseif filetype == 'markdown' then
        vim.cmd("MarkdownPreviewToggle")
    elseif filetype == 'c' then
        vim.cmd("!gcc % -o %< && ./%<")
    elseif filetype == 'cpp' then
        vim.cmd("!g++ % -o %< && ./%<")
    elseif filetype == 'javascript' then
        vim.cmd("!node %")
    elseif filetype == 'html' then
        vim.cmd("!microsoft-edge % &")
    elseif filetype == 'lua' then
        vim.cmd("!lua %")
    elseif filetype == 'matlab' then
        vim.cmd("!octave-cli %")
    end
end

vim.keymap.set("n", '<leader>r', '<cmd>lua Run()<CR>', { noremap = true })

-- -----Markdown----- --
local function is_markdown()
    return vim.bo.filetype == "markdown"
end

-- 斜体和粗体
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        -- 在Markdown模式下设置keymap
        vim.keymap.set('n', '<C-i>', '**<ESC>i', { noremap = true })
    end,
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        -- 在Markdown模式下设置keymap
        vim.keymap.set('n', '<C-b>', '****<ESC>hi', { noremap = true })
    end,
})
-- 使用pandoc渲染markdown成pdf, 和预览pdf
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        -- 在Markdown模式下设置keymap
        vim.keymap.set('n', '<leader>pz',
            ':!pandoc % --pdf-engine=xelatex -V CJKmainfont="SimSun" --template=eisvogel --listings -o %:r.pdf<CR><CR>',
            { noremap = true })
    end,
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        -- 在Markdown模式下设置keymap
        vim.keymap.set('n', '<leader>pv', ':!zathura %:r.pdf &disown<CR><CR>', { noremap = true })
    end,
})
-- image paste
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        -- 在Markdown模式下设置keymap
        vim.keymap.set({ 'n', 'i' }, '<C-v>', '<cmd>call mdip#MarkdownClipboardImage()<CR>', { noremap = true })
    end,
})
-- md-img-paste插件的配置在neovim中有bug，放在这里可以正常使用
local md_img_name = vim.fn.fnamemodify(vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), ':t:r')
local md_img_dir = 'assets.' .. md_img_name
vim.g.mdip_imgdir = md_img_dir
vim.g.mdip_imgname = 'image'
