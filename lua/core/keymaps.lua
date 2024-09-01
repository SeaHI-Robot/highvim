-- leader为;
vim.g.mapleader = ";"
vim.keymap.set({ "n", "v" }, "<A-;>", ";", { noremap = true }) -- <A-> won't work when flash.nvim is loaded



-- ----Normal---- --
-- 空格冒号
vim.keymap.set({ "n", "v" }, "<space>", ":", { noremap = true })

-- 添加空行
vim.keymap.set("n", "<C-]>", "o<ESC>", { noremap = true })
vim.keymap.set("n", "<C-[>", "O<ESC>", { noremap = true })

-- 取消高亮
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- \对应$
vim.keymap.set({ "n", "v" }, '\\', '$', { noremap = true })

-- -对应^
vim.keymap.set({ "n", "v" }, '^', '-', { noremap = true })

-- -对应^
vim.keymap.set({ "n", "v" }, '-', '^', { noremap = true })

-- 查找替换
vim.keymap.set("n", '<leader>s', ':%s///g', { noremap = true })

-- 保存
vim.keymap.set({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR><ESC>", { noremap = true, desc = "Save File" })

-- 切换显示行号
vim.keymap.set("n", "<leader>n", ":set invnumber<CR>", { noremap = true })
vim.keymap.set("n", "<leader>N", ":set invrelativenumber<CR>", { noremap = true })

-- 改变窗口大小
vim.keymap.set('n', '<S-Left>', '<cmd>vertical resize -2<CR>', { desc = "Increase Window Height", noremap = true, silent = true })
vim.keymap.set('n', '<S-Right>', '<cmd>vertical resize +2<CR>', {desc = "Decrease Window Height" , noremap = true, silent = true })
vim.keymap.set('n', '<S-Up>', '<cmd>resize +2<CR>', { desc = "Increase Window Width" , noremap = true })
vim.keymap.set('n', '<S-Down>', '<cmd>resize -2<CR>', { desc = "Decrease Window Width", noremap = true })

-- Split window on the right 
vim.keymap.set('n', '<leader>|', '<C-W>v', { noremap = true, desc = "Split Window Right" })
-- Split window on below 
vim.keymap.set('n', '<leader>-', '<C-W>s', { noremap = true, desc = "Split Window Below" })

--用 <leader> + w 代替 ctrl+ w
vim.keymap.set('n', '<leader>w', '<C-W>', { noremap = true, desc = "Switch Buffer" })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", noremap = true  })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", noremap = true  })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", noremap = true  })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", noremap = true  })

-- 关闭buffer
vim.keymap.set('n', '<leader>bc', "<cmd>bdelete<CR>", { noremap = true, desc = "Delete Buffer" })

-- 方便浏览代码
vim.keymap.set('n', '<A-]>', "jzz", { noremap = true })
vim.keymap.set('n', '<A-[>', "kzz", { noremap = true })
vim.keymap.set('n', '<C-]>', "jzz", { noremap = true })
vim.keymap.set('n', '<C-[>', "kzz", { noremap = true })

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down", noremap = true })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up", noremap = true })

-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below", noremap = true })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above", noremap = true })



-- ----Visual---- --
-- Move lines
vim.keymap.set('v', "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move the Selected Down" })
vim.keymap.set('v', "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move the Selected Up" })



-- ----Insert---- --
vim.keymap.set("i", "jf", "<ESC>", { noremap = true })
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



-- ----Cmd---- --
vim.keymap.set("c", "<C-j>", "<down>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<up>", { noremap = true })
vim.keymap.set("c", "<C-b>", "<left>", { noremap = true })
vim.keymap.set("c", "<C-f>", "<right>", { noremap = true })
vim.keymap.set("c", "<C-a>", "<home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<end>", { noremap = true })
-- vim.keymap.set("c", "<C-d>", "<delete>", { noremap = true }) <Conflict with Gnome Terminal keybinds>


-- ----Terminal---- --
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode", noremap = true })
-- vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window", noremap = true })
-- vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window", noremap = true })
-- vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window", noremap = true })
-- vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window", noremap = true })
-- vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal", noremap = true })
-- vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore", noremap = true })

-- ----others---- --
-- better indenting
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All", noremap = true })

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
        -- vim.keymap.set('n', '<C-b>', '****<ESC>hi', { noremap = true })
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
-- vim.g.mdip_imgname = 'image'


-- -----lazygit----- --
vim.keymap.set("n", '<leader>lg', '<cmd>LazyGit<CR>', { noremap = true })


-- -----navbuddy----- --
vim.keymap.set("n", '<leader>O', '<cmd>Navbuddy<CR>', { noremap = true })
