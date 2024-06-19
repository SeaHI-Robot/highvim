"
"  __  __        __     _____ __  __ ____   ____
" |  \/  |_   _  \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | |  \ \ / / | || |\/| | |_) | |
" | |  | | |_| |   \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, |    \_/  |___|_|  |_|_| \_\\____|
"         |___/
"================================================
"
"
"
" ========== 普通配置 ==========
colorscheme industry
inoremap jf <Esc>
nnoremap <space> :
vnoremap <space> :
set encoding=utf-8
set fileencoding=utf-8
" 缩进
set autoindent
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
" title
set title
" 行号
set number
" \ 代替 $
nnoremap \ $
vnoremap \ $
" 允许鼠标操作
" set mouse=a
nnoremap <c-m> :set mouse+=a<cr>
" 非gvim无法实现寄存器和系统剪贴板同步
" set clipboard=unnamedplus 
" 不保存swap文件
set noswapfile
" 不区分大小写搜索
set ignorecase
set smartcase
" 启动语法高亮
syntax on
" cmmand 模式下选项菜单
set wildmenu
" 启动自动缩进
filetype plugin indent on
" leader键设置为","
let mapleader = ";"
" 保存
nnoremap <C-s> :w<CR>
" 文件改动自动读取
set autoread
" 设置当前行高亮
set cursorline
" 使用 Shift+左/右箭头调整窗口宽度
nnoremap <S-Left> :vertical resize -2<CR>
nnoremap <S-Right> :vertical resize +2<CR>
" 使用 Shift+上/下箭头调整窗口高度
nnoremap <S-Up> :resize +2<CR>
nnoremap <S-Down> :resize -2<CR>
" 防止wrap
set nowrap 
" 高亮搜索
set hlsearch
nnoremap <leader>q :nohl<CR>
" 新窗口在右下
set splitright
set splitbelow
" 切换是否显示行号
nnoremap <leader>n :set invnumber<CR>
" 切换是否显示相对行号
nnoremap <leader>N :set invrelativenumber<CR>
" 查找替换
nnoremap <leader>s :%s///g
" 切换Buffer
nnoremap <leader><Tab> :bNext<CR>
nnoremap <leader>bc :bdelete<CR>
" nnoremap <leader>1 :b1<CR>
" nnoremap <leader>2 :b2<CR>
" nnoremap <leader>3 :b3<CR>
" nnoremap <leader>4 :b4<CR>
" nnoremap <leader>5 :b5<CR>
" nnoremap <leader>6 :b6<CR>
" visual模式下整行移动
vnoremap J :m '>+1<CR>gv=gv 
vnoremap K :m '<-2<CR>gv=gv 
" insert模式下自动补全括号和引号(已使用coc-pairs解决)
" inoremap { {}<ESC>i
" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap ' ''<ESC>i
" inoremap "" ""<ESC>i
" inoremap < <><ESC>i
" normal模式下添加空行
nnoremap <C-l> o<Esc>

" ========== 分屏配置 ==========
" 用 <leader> + v 代替 ctrl+ w 再按 v 进行左右分屏
nnoremap <leader>v <C-W>v
" 用 <leader> + w 代替 ctrl+ w 再按 w 进行分屏间切换
nnoremap <leader>w <C-W>w
" 用 <leader> + h 代替 ctrl+ w 再按 h 进行向左边分屏切换
nnoremap <leader>h <C-W>h
" 用 <leader> + l 代替 ctrl+ w 再按 l 进行向右边分屏切换
nnoremap <leader>l <C-W>l
" 用 <leader> + H 代替 ctrl+ w 再按 H 进行向左边移动
nnoremap <leader>H <C-W>H
" 用 <leader> + L 代替 ctrl+ w 再按 L 进行向右边移动
nnoremap <leader>L <C-W>L
" 用 <leader> + j 代替 ctrl+ w 再按 j 进行向下边分屏切换
nnoremap <leader>j <C-W>j
" 用 <leader> + k 代替 ctrl+ w 再按 k 进行向上边分屏切换
nnoremap <leader>k <C-W>k
" 用 <leader> + J 代替 ctrl+ w 再按 J 进行向下边移动
nnoremap <leader>J <C-W>J
" 用 <leader> + K 代替 ctrl+ w 再按 K 进行向上边移动
nnoremap <leader>K <C-W>K


