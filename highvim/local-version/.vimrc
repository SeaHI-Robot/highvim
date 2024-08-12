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
inoremap jf <Esc>
nnoremap <space> :
vnoremap <space> :
set encoding=utf-8
set fileencoding=utf-8

" 缩进
set autoindent
set cindent
set smartindent
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set cindent

" title
set title

" 行号
set number
set relativenumber

" \ 代替 $
nnoremap \ $
vnoremap \ $

" - 代替 ^
nnoremap - ^
vnoremap - ^

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

" 实时搜索
set incsearch

" 关闭高亮
nnoremap <ESC> :nohl<CR>
nnoremap <leader>q :nohl<CR>

" 统一采用decimal十进制计数法，针对 <C-a> <C-a> 操作
set nrformats=

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
nnoremap <C-w> :bdelete<CR>
nnoremap <S-h> <cmd>bprevious<CR>
nnoremap <S-l> <cmd>bNext<CR>
" nnoremap <leader>1 :b1<CR>
" nnoremap <leader>2 :b2<CR>
" nnoremap <leader>3 :b3<CR>
" nnoremap <leader>4 :b4<CR>
" nnoremap <leader>5 :b5<CR>
" nnoremap <leader>6 :b6<CR>

" visual模式下整行移动
vnoremap <S-j> :m '>+1<CR>gv=gv 
vnoremap <S-k> :m '<-2<CR>gv=gv 

" 设置折叠 `zc` `zo` `zO` `za` `zR` `zM` ...... 
set foldenable
set foldmethod=syntax
autocmd BufEnter * setlocal nofoldenable
nnoremap <leader>0 za

nnoremap zm zM
nnoremap zM zR

" insert模式下自动补全括号和引号(已使用coc-pairs解决) <Deprecated>
" inoremap { {}<ESC>i
" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap ' ''<ESC>i
" inoremap "" ""<ESC>i
" inoremap < <><ESC>i

" normal模式下添加空行
nnoremap <C-]> o<Esc>
nnoremap <C-[> O<Esc>

" cmd emacs mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>
" cnoremap <c-d> <del> <Conflict>
cnoremap <c-b> <left>
cnoremap <c-f> <right>

" insert emacs mode
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-d> <del>
inoremap <c-h> <left>
inoremap <c-l> <right>

" 方便浏览代码
nnoremap <C-j> jzz
nnoremap <C-k> kzz


" ========== runtime配置 ==========
nnoremap <leader>r :call Run()<CR>
func! Run() 
    exec "w"
    if &filetype == 'python'
        exec "AsyncRun -mode=term -pos=floaterm python3 %"
    elseif &filetype == 'markdown'
        exec "MarkdownPreviewToggle"
    elseif &filetype == 'c'
        exec "AsyncRun -mode=term -pos=floaterm gcc % -o %< && ./%<"
    elseif &filetype == 'cpp'
        exec "AsyncRun -mode=term -pos=floaterm g++ % -o %< && ./%<"
    elseif &filetype == 'javascript'
        exec "AsyncRun -mode=term -pos=floaterm node %"
    elseif &filetype == 'html'
        exec "!microsoft-edge % &"
    elseif &filetype == 'lua'
        exec "AsyncRun -mode=term -pos=floaterm lua %"
    endif
endfunc


" ========== VimPlug ==========
" plugin configs - using VimPlug 
call plug#begin(expand('~/.vim/plugged')) 
  Plug 'preservim/NERDTree'  "文件浏览插件
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "NERDTree的插件
  Plug 'RRethy/vim-illuminate'
  Plug 'ryanoasis/vim-devicons' " File icon
  Plug 'itchyny/lightline.vim'  "底部状态栏插件
  Plug 'mengelbrecht/lightline-bufferline' "lightline上显示buffer作为tab 
  Plug 'luochen1990/rainbow'  "文件高亮显示
  Plug 'preservim/nerdcommenter' "注释插件
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} "markdown preview 
  Plug 'img-paste-devs/img-paste.vim' "复制剪贴板图像到md中
  Plug 'vim-python/python-syntax'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'majutsushi/tagbar' "变量，函数名等归类显示
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'lervag/vimtex' "vim latex插件
  Plug 'voldikss/vim-floaterm' "浮动终端
  Plug 'skywind3000/asyncrun.vim' 
  Plug 'skywind3000/asyncrun.extra'
  Plug 'voldikss/vim-translator' "翻译单词，ctrl-t触发
  Plug 'farmergreg/vim-lastplace' "记录上一次退出时的位置
  Plug 'honza/vim-snippets'   
  Plug 'osyo-manga/vim-anzu' " 搜索显示
  " Plug 'godlygeek/tabular' vim-markdown依赖
  " Plug 'plasticboy/vim-markdown' markdown插件,我感觉没必要使用
  " Plug 'mg979/vim-visual-multi', {'branch': 'master'} vim多光标插件，暂时没配置
  " Plug 'mzlogin/vim-markdown-toc' 不是很好，生成的markdown目录typora识别不了
  " Plug 'vim-scripts/TabBar' 顶部显示buffer作为tab，alt+数字键切换，美观程度一般
  " Plug 'SirVer/ultisnips' 我没用ultisnips，我的组合是vim-snippets + coc.nvim中的coc-snippets
  " Plug 'honza/vim-snippets' 提供常用的snipmate格式的snippets，我把snippets单独放在了.vim/目录下故不需要vim-snippets了
  " Plug 'vim-airline/vim-airline' 我用的lightline，故未使用
  " Plug 'vim-airline/vim-airline-themes' 
  
  " vim colorscheme plugin
  Plug 'arcticicestudio/nord-vim' "nord配色低饱和，我很喜欢，但是nord-vim字体太过单调
  Plug 'ghifarit53/tokyonight-vim'
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  

call plug#end()



" 用 <leader> + v 代替 ctrl+ w 再按 v 进行左右分屏
nnoremap <leader>\| <cmd>vsplit<CR>
nnoremap <leader>- <cmd>split<CR>
" 用 <leader> + w 代替 ctrl+ w 再按 w 进行分屏间切换
nnoremap <leader>w <C-W>

" Go to Left Window
nnoremap <C-l> <C-w>h
" Go to Right Window
nnoremap <C-h> <C-w>l
" Go to Upper Window
" nnoremap <C-k> <C-w>k
" Go to Lower Window
" nnoremap <C-j> <C-w>j



" NERDTree config - Press <F2> to toggle
" map <leader>e :NERDTreeMirror<CR>
nnoremap <C-e> <cmd>NERDTreeToggle<CR>
nnoremap <C-b> <cmd>NERDTreeClose<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 25


" vim-illuminate config
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END
" augroup illuminate_augroup
"     autocmd!
"     autocmd VimEnter * hi link illuminatedWord CursorLine
" augroup END
" augroup illuminate_augroup
"     autocmd!
"     autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
" augroup END

" lightline.vim config
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'catppuccin_frappe', 
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus','readonly', 'filename', 'modified', 'method' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'separator': {'left': '', 'right': ' '},
      \ 'subseparator': {'left': '', 'right': '|'},
      \ 'component_function': {
      \   'blame': 'LightlineGitBlame',
      \ }
      \ }
function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

" bufferline-lightline
set showtabline=2
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#enable_nerdfont = 1
let g:lightline#bufferline#icon_position = 'right'
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#modified = ' '


" rainbow config
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle


" tagbar config
nnoremap <leader>o :TagbarToggle<CR> 
" o means outline


" nerdcommenter config
" As default <leader> + c + space to toggle comment status
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims=1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" map ctrl+/ to <leader>c<space>
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv


" ColorSchemes
set termguicolors
" 
" nord theme config
" colorscheme nord
"
" tokyonight theme config
" tokyonight_style available: night, storm
" let g:tokyonight_style = 'storm'
" let g:tokyonight_enable_italic = 1
" colorscheme tokyonight
"
" catppuccin config
colorscheme catppuccin_frappe

" coc.nvim config
let g:coc_global_extensions = [
    \'coc-vimlsp', 'coc-json', 'coc-python',
    \'coc-clangd', 'coc-marketplace', 'coc-html',
    \'coc-snippets', 'coc-sh', 'coc-prettier', 'coc-pairs',
    \'coc-git', 'coc-fzf-preview']
" other useful coc extension: coc-emoji coc-vimtex coc-lua
set updatetime=100
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-o> to trigger completion
inoremap <silent><expr> <c-o> coc#refresh()

" Use `<leader>[` and `<leader>]` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nnoremap <leader> [ <Plug>(coc-diagnostic-prev)
nnoremap <leader> ] <Plug>(coc-diagnostic-next)

" GoTo code navigation
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gD <Plug>(coc-type-definition)
" nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Remap keys for applying code actions at the cursor position
nmap <leader>ca  <Plug>(coc-codeaction-cursor)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nnoremap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-snippets configuration
" Use <Tab> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<Tab>'
" Use <S-Tab> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<S-Tab>'

" coc-pairs
autocmd FileType markdown let b:coc_pairs_disabled = ['`']
autocmd FileType tex let b:coc_pairs = [["$", "$"]]

" coc-git
nnoremap <leader>gp :CocCommand git.chunkInfo<CR>
nnoremap <leader>gr :CocCommand git.chunkUndo<CR>

" fzf config
nnoremap <leader>ff :FZF<CR>
" nnoremap <leader>fd :CocCommand fzf-preview.DirectoryFiles<CR>
" ProjectGrep 后面跟需要grep的参数
" nnoremap <leader>fg :CocCommand fzf-preview.ProjectGrep
" nnoremap <leader>fb :CocCommand fzf-preview.AllBuffers<CR>



" floaterm config
nnoremap <silent> <leader><space> :FloatermToggle<CR> 
tnoremap <silent> <leader>/ <C-\><C-N>:FloatermKill<CR>
tnoremap <silent> <leader><space> <C-\><C-N>:FloatermHide<CR>
" asyncrun floaterm
nnoremap <leader>R :AsyncRun -mode=term -pos=floaterm 


" ========== Markdown 配置 ==========
" 加粗和斜体
autocmd Filetype markdown inoremap <C-i> **<ESC>i
autocmd Filetype markdown inoremap <C-b> ****<ESC>hi
" 使用pandoc渲染markdown成pdf
autocmd Filetype markdown nnoremap <leader>pz :!pandoc % --pdf-engine=xelatex -V CJKmainfont="SimSun" --template=eisvogel --listings -o %:r.pdf<CR><CR>
autocmd Filetype markdown nnoremap <leader>pv :!zathura %:r.pdf &disown<CR><CR> 
" 打开目录，这个应该是vim-markdown提供的，但我已经不用它了
" autocmd Filetype markdown nnoremap toc :Toc<CR>

" markdown-preview.nvim config
" recognized filetypes, only these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']
" set default theme (dark or light)
" By default the theme is defined according to the preferences of the system
" let g:mkdp_theme = 'dark'
" 自定义ip，方便远程的时候使用
" Useful when you work in remote Vim and preview on local browser.
" For more details see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
" let g:mkdp_open_ip = ''
" 指定css，必须是全局路径 默认的很像github了，故可以不做更改
" let g:mkdp_markdown_css=''
"
" md-img-paste.vim config
"设置默认储存照片的文件夹
let g:md_img_filename = expand('%:t:r')
let g:mdip_imgdir = 'assets.' . g:md_img_filename 
"设置默认图片名称。当图片名称没有给出时，使用默认图片名称
let g:mdip_imgname = 'image'
"设置快捷键粘贴图片 Ctrl+v 
autocmd FileType markdown inoremap <silent> <C-v> <cmd>call mdip#MarkdownClipboardImage()<CR>
autocmd FileType markdown nnoremap <silent> <C-v> <cmd>call mdip#MarkdownClipboardImage()<CR>


" vimtex config
" \ll开启连续编译，\lv预览pdf，\lc清除文件
" 参考https://castel.dev/post/lecture-notes-1/
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_compiler_latexmk_engines={'_':'-xelatex'}
let g:vimtex_compiler_latexrun_engines={'_':'xelatex'}
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'


" vim-translator
let g:translator_default_engines = ['bing']
" ['bing', 'google', 'haici', 'youdao']
""" Configuration example
" Echo translation in the cmdline
" nmap <silent> <Leader>t <Plug>Translate
" vmap <silent> <Leader>t <Plug>TranslateV
" Display translation in a window
nnoremap <silent> <C-t> <Plug>TranslateW
vnoremap <silent> <C-t> <Plug>TranslateWV
" Replace the text with translation
" nmap <silent> <Leader>r <Plug>TranslateR
" vmap <silent> <Leader>r <Plug>TranslateRV
" Translate the text in clipboard
" nmap <silent> <Leader>x <Plug>TranslateX


" vim-anzu
" mapping
" nmap n <Plug>(anzu-n-with-echo)
" nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" statusline
set statusline=%{anzu#search_status()}
" if start anzu-mode key mapping
" anzu-mode is anzu(12/51) in screen
nmap n <Plug>(anzu-mode-n)
nmap N <Plug>(anzu-mode-N)
