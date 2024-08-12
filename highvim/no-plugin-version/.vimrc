" __     _____ __  __   _   _  ___    ____  _    _   _  ____ ___ _   _
" \ \   / /_ _|  \/  | | \ | |/ _ \  |  _ \| |  | | | |/ ___|_ _| \ | |
"  \ \ / / | || |\/| | |  \| | | | | | |_) | |  | | | | |  _ | ||  \| |
"   \ V /  | || |  | | | |\  | |_| | |  __/| |__| |_| | |_| || || |\  |
"    \_/  |___|_|  |_| |_| \_|\___/  |_|   |_____\___/ \____|___|_| \_|
"
"================================================
"
" 参考了https://gitee.com/mirrorvim/vim-fast/raw/master/vimrc-no-plug
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
set completeopt=menuone,preview,noselect " 补全时不显示窗口，只显示补全列表
set omnifunc=syntaxcomplete#Complete     " 设置全能补全
set shortmess+=c                         " 设置补全静默
set cpt+=kspell                          " 设置补全单词
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

" insert模式下自动补全括号和引号
inoremap { {}<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap ' ''<ESC>i
" inoremap < <><ESC>i
func! s:Judge(ch,mode)
	if a:mode!='c'
		let ch=getline('.')[col('.')-1]
	else
		let ch=getcmdline()[getcmdpos()-1]
	endif
	if a:ch=='"'||a:ch=="'"||a:ch=='`'
		if ch!=a:ch
			return a:ch.a:ch."\<left>"
		endif
	endif
	if ch==a:ch
		return "\<right>"
	endif
	return a:ch
endfunc
inoremap <expr><silent>} <sid>Judge('}','i')
inoremap <expr><silent>) <sid>Judge(')','i')
inoremap <expr><silent>] <sid>Judge(']','i')
inoremap <expr><silent>' <sid>Judge("'",'i')
" inoremap <expr><silent>> <sid>Judge('>','i')

" normal模式下添加空行
nnoremap <C-l> o<Esc>

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

" netrw
nnoremap <C-e> :Lexplore<CR>
" 设置浏览器的显示格式（0-4）
let g:netrw_liststyle = 3
" 是否隐藏 banner
let g:netrw_banner = 0
" 打开文件时在水平分割窗口中显示
let g:netrw_browse_split = 4
" 设置垂直分割窗口的宽度
let g:netrw_winsize = 20
" 设置隐藏文件显示
let g:netrw_list_hide = '^\./$,^\../$,^\..*$'
" 自动切换到目录
let g:netrw_keepdir = 0
" 使 netrw 忽略文件
let g:netrw_list_hide = '.*\.swp$,.git$,.hg$,.svn$'
" 设置按键绑定
let g:netrw_altv = 1


" 状态栏配置
set laststatus=2
function! GetMode()
	let m = mode()|let s:str=''|let s:color='#9ECE6A'
	if m == 'R'|let s:color='#F7768E'|let s:str= 'Replace '
	elseif m == 'v'|let s:color='#F7768E'|let s:str= 'Visual '
	elseif m == 'i'|let s:color='#9ECE6A'|let s:str= 'Insert '
	elseif m == 't'|let s:color='#7AA2F7'|let s:str= 'Terminal '
	else|let s:color='#7AA2F7'|let s:str= 'Normal '
	endif
	exec 'highlight User3 font=#000000 guifg=#1a1b26 guibg='.s:color
	exec 'highlight User4 font=#000000 guifg='.s:color.' guibg=#232433'
	redraw|return s:str
endfunction

let g:status_git_branch=""
if has('nvim')
	let g:status_git_branch=' nvim'.' |'
endif
func! GitBranchShow(chan,msg)
	let g:status_git_branch=" ".a:msg." |"
endfunc
if g:status_git_branch==""
	call job_start("git rev-parse --abbrev-ref HEAD",{"out_cb":"GitBranchShow"})
endif

set statusline=%3*\ %{GetMode()}
set statusline+=%4*\ %{g:status_git_branch}\ %F\ \|%m%r%h%w%=
set statusline+=%3*\ %Y\ |
set statusline+=%3*¦%{\"\".(\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}¦
set statusline+=%3*☰\ %l/%-L¦\ %v\ ¦%3p%%¦


" highlight 
highlight User1 font=#000000 guifg=#1a1b26 guibg=#9ECE6A
highlight User2 font=#000000 guifg=#9ECE6A guibg=#232433
highlight User3 font=#000000 guifg=#1a1b26 guibg=#9ECE6A
highlight User4 font=#000000 guifg=#9ECE6A guibg=#232433
highlight User5 font=#000000 guifg=#1a1b26 guibg=#7AA2F7
highlight User6 font=#000000 guifg=#7AA2F7 guibg=#232433


" 启用 buffer 栏
set showtabline=2



" 下一次打开文件保持上一次退出的位置
if has("autocmd")
  " 当进入缓冲区时执行恢复光标位置的命令
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif


" 代码补全
" config complete {{{
inoremap <silent><expr>/ complete_info(["selected"])["selected"]!=-1&&getline(line('.'))[col('.')-2]=='/'?
			\ "\<bs>/\<c-x>\<c-f>":
			\ "/\<c-x>\<c-f>"
let g:cmpX=-1|let g:cmpY=-1
function! s:feed_popup()
	if getline('.')[col('.')-1]=='/'|return|endif
	let x = col('.') - 1|let y = line('.') - 1
	if g:cmpX==x&&g:cmpY==y|return|endif
	let s:min_complete=2
	let s:context=strpart(getline('.'), 0, col('.') - 1)
	let s:match= matchlist(s:context, '\(\k\{' . s:min_complete . ',}\)$')
	if empty(s:match)|return|endif
	silent! call feedkeys("\<c-n>", 'n')
	let g:cmpX=x|let g:cmpY=y
	return
endfunction
augroup Complete
	au!
	au CursorMovedI * nested call s:feed_popup()
	au FileType text setlocal spell|setlocal nospell
augroup END
inoremap <silent><expr><TAB>
			\ pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr><CR>
			\ pumvisible() ? "\<C-n>" : "\<CR>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"}}}

" 颜色主题
" tokyonight color inside,donnot change it {{{
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2
let s:tmux = executable('tmux') && $TMUX !=# ''
let g:colors_name = 'tokyonight'|let s:configuration = {}
let s:configuration.style = get(g:, 'tokyonight_style', 'night')
let s:configuration.transparent_background = get(g:, 'tokyonight_transparent_background', 0)
let s:configuration.menu_selection_background = get(g:, 'tokyonight_menu_selection_background', 'green')
let s:configuration.disable_italic_comment = get(g:, 'tokyonight_disable_italic_comment', 0)
let s:configuration.enable_italic = get(g:, 'tokyonight_enable_italic', 0)
let s:configuration.cursor = get(g:, 'tokyonight_cursor', 'auto')
let s:configuration.current_word = get(g:, 'tokyonight_current_word', get(g:, 'tokyonight_transparent_background', 0) == 0 ? 'grey background' : 'bold')
if s:configuration.style ==# 'night'
	let s:palette = {
				\ 'black':      ['#24283B',   '237',  'DarkGrey'],
				\ 'bg0':        ['#24283B',   '235',  'Black'],
				\ 'bg1':        ['#232433',   '236',  'DarkGrey'],
				\ 'bg2':        ['#2a2b3d',   '236',  'DarkGrey'],
				\ 'bg3':        ['#32344a',   '237',  'DarkGrey'],
				\ 'bg4':        ['#3b3d57',   '237',  'Grey'],
				\ 'bg_red':     ['#ff7a93',   '203',  'Red'],
				\ 'diff_red':   ['#803d49',   '52',   'DarkRed'],
				\ 'bg_green':   ['#b9f27c',   '107',  'Green'],
				\ 'diff_green': ['#618041',   '22',   'DarkGreen'],
				\ 'bg_blue':    ['#7da6ff',   '110',  'Blue'],
				\ 'diff_blue':  ['#3e5380',   '17',   'DarkBlue'],
				\ 'fg':         ['#a9b1d6',   '250',  'White'],
				\ 'red':        ['#F7768E',   '203',  'Red'],
				\ 'orange':     ['#FF9E64',   '215',  'Orange'],
				\ 'yellow':     ['#E0AF68',   '179',  'Yellow'],
				\ 'green':      ['#9ECE6A',   '107',  'Green'],
				\ 'blue':       ['#7AA2F7',   '110',  'Blue'],
				\ 'purple':     ['#ad8ee6',   '176',  'Magenta'],
				\ 'grey':       ['#444B6A',   '246',  'LightGrey'],
				\ 'none':       ['NONE',      'NONE', 'NONE']
				\ }
elseif s:configuration.style ==# 'storm'
	let s:palette = {
				\ 'black':      ['#06080a',   '237',  'DarkGrey'],
				\ 'bg0':        ['#24283b',   '235',  'Black'],
				\ 'bg1':        ['#282d42',   '236',  'DarkGrey'],
				\ 'bg2':        ['#2f344d',   '236',  'DarkGrey'],
				\ 'bg3':        ['#333954',   '237',  'DarkGrey'],
				\ 'bg4':        ['#3a405e',   '237',  'Grey'],
				\ 'bg_red':     ['#ff7a93',   '203',  'Red'],
				\ 'diff_red':   ['#803d49',   '52',   'DarkRed'],
				\ 'bg_green':   ['#b9f27c',   '107',  'Green'],
				\ 'diff_green': ['#618041',   '22',   'DarkGreen'],
				\ 'bg_blue':    ['#7da6ff',   '110',  'Blue'],
				\ 'diff_blue':  ['#3e5380',   '17',   'DarkBlue'],
				\ 'fg':         ['#a9b1d6',   '250',  'White'],
				\ 'red':        ['#F7768E',   '203',  'Red'],
				\ 'orange':     ['#FF9E64',   '215',  'Orange'],
				\ 'yellow':     ['#E0AF68',   '179',  'Yellow'],
				\ 'green':      ['#9ECE6A',   '107',  'Green'],
				\ 'blue':       ['#7AA2F7',   '110',  'Blue'],
				\ 'purple':     ['#ad8ee6',   '176',  'Magenta'],
				\ 'grey':       ['#444B6A',   '246',  'LightGrey'],
				\ 'none':       ['NONE',      'NONE', 'NONE']
				\ }
endif
if (has('termguicolors') && &termguicolors) || has('gui_running')  " guifg guibg gui cterm guisp
	function! s:HL(group, fg, bg, ...)
		let hl_string = [ 'highlight', a:group, 'guifg=' . a:fg[0], 'guibg=' . a:bg[0], ]
		if a:0 >= 1
			if a:1 ==# 'undercurl'
				if !s:tmux|call add(hl_string, 'gui=undercurl')
				else|call add(hl_string, 'gui=underline')
				endif
				call add(hl_string, 'cterm=underline')
			else|call add(hl_string, 'gui=' . a:1)|call add(hl_string, 'cterm=' . a:1)
			endif
		else|call add(hl_string, 'gui=NONE')|call add(hl_string, 'cterm=NONE')
		endif
		if a:0 >= 2|call add(hl_string, 'guisp=' . a:2[0])|endif
		execute join(hl_string, ' ')
	endfunction
elseif s:t_Co >= 256
	function! s:HL(group, fg, bg, ...)
		let hl_string = [ 'highlight', a:group, 'ctermfg=' . a:fg[1], 'ctermbg=' . a:bg[1]]
		if a:0 >= 1
			if a:1 ==# 'undercurl'|call add(hl_string, 'cterm=underline')
			else|call add(hl_string, 'cterm=' . a:1)
			endif
		else|call add(hl_string, 'cterm=NONE')
		endif
		execute join(hl_string, ' ')
	endfunction
else  " ctermfg ctermbg cterm
	function! s:HL(group, fg, bg, ...)
		let hl_string = [ 'highlight', a:group, 'ctermfg=' . a:fg[2], 'ctermbg=' . a:bg[2]]
		if a:0 >= 1
			if a:1 ==# 'undercurl'|call add(hl_string, 'cterm=underline')
			else|call add(hl_string, 'cterm=' . a:1)
			endif
		else|call add(hl_string, 'cterm=NONE')
		endif
		execute join(hl_string, ' ')
	endfunction
endif
if s:configuration.transparent_background
	call s:HL('Normal', s:palette.fg, s:palette.none)
	call s:HL('Terminal', s:palette.fg, s:palette.none)
	call s:HL('EndOfBuffer', s:palette.bg0, s:palette.none)
	call s:HL('FoldColumn', s:palette.grey, s:palette.none)
	call s:HL('Folded', s:palette.grey, s:palette.none)
	call s:HL('SignColumn', s:palette.fg, s:palette.none)
	call s:HL('ToolbarLine', s:palette.fg, s:palette.none)
else
	call s:HL('Normal', s:palette.fg, s:palette.bg0)
	call s:HL('Terminal', s:palette.fg, s:palette.bg0)
	call s:HL('EndOfBuffer', s:palette.bg0, s:palette.bg0)
	call s:HL('FoldColumn', s:palette.grey, s:palette.bg1)
	call s:HL('Folded', s:palette.grey, s:palette.bg1)
	call s:HL('SignColumn', s:palette.fg, s:palette.bg1)
	call s:HL('ToolbarLine', s:palette.fg, s:palette.bg2)
endif
call s:HL('ColorColumn', s:palette.none, s:palette.bg1)
call s:HL('Conceal', s:palette.grey, s:palette.none)
if s:configuration.cursor ==# 'auto'|call s:HL('Cursor', s:palette.none, s:palette.none, 'reverse')
elseif s:configuration.cursor ==# 'red'|call s:HL('Cursor', s:palette.bg0, s:palette.red)
elseif s:configuration.cursor ==# 'green'|call s:HL('Cursor', s:palette.bg0, s:palette.green)
elseif s:configuration.cursor ==# 'blue'|call s:HL('Cursor', s:palette.bg0, s:palette.blue)
endif
highlight! link vCursor Cursor
highlight! link iCursor Cursor
highlight! link lCursor Cursor
highlight! link CursorIM Cursor
call s:HL('CursorColumn', s:palette.none, s:palette.bg1)
call s:HL('CursorLine', s:palette.none, s:palette.bg1)
call s:HL('LineNr', s:palette.grey, s:palette.none)
if &relativenumber == 1 && &cursorline == 0|call s:HL('CursorLineNr', s:palette.fg, s:palette.none)
else|call s:HL('CursorLineNr', s:palette.fg, s:palette.bg1)
endif
call s:HL('DiffAdd', s:palette.none, s:palette.diff_green)
call s:HL('DiffChange', s:palette.none, s:palette.diff_blue)
call s:HL('DiffDelete', s:palette.none, s:palette.diff_red)
call s:HL('DiffText', s:palette.none, s:palette.none, 'reverse')
call s:HL('Directory', s:palette.green, s:palette.none)
call s:HL('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
call s:HL('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call s:HL('ModeMsg', s:palette.fg, s:palette.none, 'bold')
call s:HL('MoreMsg', s:palette.blue, s:palette.none, 'bold')
call s:HL('IncSearch', s:palette.bg0, s:palette.bg_red)
call s:HL('Search', s:palette.bg0, s:palette.bg_green)
call s:HL('MatchParen', s:palette.none, s:palette.bg4)
call s:HL('NonText', s:palette.bg4, s:palette.none)
call s:HL('Whitespace', s:palette.bg4, s:palette.none)
call s:HL('SpecialKey', s:palette.bg4, s:palette.none)
call s:HL('Pmenu', s:palette.fg, s:palette.bg2)
call s:HL('PmenuSbar', s:palette.none, s:palette.bg2)
if s:configuration.menu_selection_background ==# 'blue'
	call s:HL('PmenuSel', s:palette.bg0, s:palette.bg_blue)
	call s:HL('WildMenu', s:palette.bg0, s:palette.bg_blue)
elseif s:configuration.menu_selection_background ==# 'green'
	call s:HL('PmenuSel', s:palette.bg0, s:palette.bg_green)
	call s:HL('WildMenu', s:palette.bg0, s:palette.bg_green)
elseif s:configuration.menu_selection_background ==# 'red'
	call s:HL('PmenuSel', s:palette.bg0, s:palette.bg_red)
	call s:HL('WildMenu', s:palette.bg0, s:palette.bg_red)
endif
call s:HL('PmenuThumb', s:palette.none, s:palette.grey)
call s:HL('Question', s:palette.yellow, s:palette.none)
call s:HL('SpellBad', s:palette.red, s:palette.none, 'undercurl', s:palette.red)
call s:HL('SpellCap', s:palette.yellow, s:palette.none, 'undercurl', s:palette.yellow)
call s:HL('SpellLocal', s:palette.blue, s:palette.none, 'undercurl', s:palette.blue)
call s:HL('SpellRare', s:palette.purple, s:palette.none, 'undercurl', s:palette.purple)
call s:HL('StatusLine', s:palette.fg, s:palette.bg3)
call s:HL('StatusLineTerm', s:palette.fg, s:palette.bg3)
call s:HL('StatusLineNC', s:palette.grey, s:palette.bg1)
call s:HL('StatusLineTermNC', s:palette.grey, s:palette.bg1)
call s:HL('TabLine', s:palette.fg, s:palette.bg4)
call s:HL('TabLineFill', s:palette.grey, s:palette.bg1)
call s:HL('TabLineSel', s:palette.bg0, s:palette.bg_red)
call s:HL('VertSplit', s:palette.black, s:palette.none)
call s:HL('Visual', s:palette.none, s:palette.bg3)
call s:HL('VisualNOS', s:palette.none, s:palette.bg3, 'underline')
call s:HL('QuickFixLine', s:palette.blue, s:palette.none, 'bold')
call s:HL('Debug', s:palette.yellow, s:palette.none)
call s:HL('debugPC', s:palette.bg0, s:palette.green)
call s:HL('debugBreakpoint', s:palette.bg0, s:palette.red)
call s:HL('ToolbarButton', s:palette.bg0, s:palette.bg_blue)
call s:HL('Type', s:palette.blue, s:palette.none, 'italic')
call s:HL('Structure', s:palette.blue, s:palette.none, 'italic')
call s:HL('StorageClass', s:palette.blue, s:palette.none, 'italic')
call s:HL('Identifier', s:palette.orange, s:palette.none, 'italic')
call s:HL('Constant', s:palette.orange, s:palette.none, 'italic')
call s:HL('PreProc', s:palette.red, s:palette.none)
call s:HL('PreCondit', s:palette.red, s:palette.none)
call s:HL('Include', s:palette.red, s:palette.none)
call s:HL('Keyword', s:palette.red, s:palette.none)
call s:HL('Define', s:palette.red, s:palette.none)
call s:HL('Typedef', s:palette.red, s:palette.none)
call s:HL('Exception', s:palette.red, s:palette.none)
call s:HL('Conditional', s:palette.red, s:palette.none)
call s:HL('Repeat', s:palette.red, s:palette.none)
call s:HL('Statement', s:palette.red, s:palette.none)
call s:HL('Macro', s:palette.purple, s:palette.none)
call s:HL('Error', s:palette.red, s:palette.none)
call s:HL('Label', s:palette.purple, s:palette.none)
call s:HL('Special', s:palette.purple, s:palette.none)
call s:HL('SpecialChar', s:palette.purple, s:palette.none)
call s:HL('Boolean', s:palette.purple, s:palette.none)
call s:HL('String', s:palette.yellow, s:palette.none)
call s:HL('Character', s:palette.yellow, s:palette.none)
call s:HL('Number', s:palette.purple, s:palette.none)
call s:HL('Float', s:palette.purple, s:palette.none)
call s:HL('Function', s:palette.green, s:palette.none)
call s:HL('Operator', s:palette.red, s:palette.none)
call s:HL('Title', s:palette.red, s:palette.none, 'bold')
call s:HL('Tag', s:palette.orange, s:palette.none)
call s:HL('Delimiter', s:palette.fg, s:palette.none)
call s:HL('Comment', s:palette.grey, s:palette.none, 'italic')
call s:HL('SpecialComment', s:palette.grey, s:palette.none, 'italic')
call s:HL('Todo', s:palette.blue, s:palette.none, 'italic')
call s:HL('Ignore', s:palette.grey, s:palette.none)
call s:HL('Underlined', s:palette.none, s:palette.none, 'underline')
call s:HL('Fg', s:palette.fg, s:palette.none)
call s:HL('Grey', s:palette.grey, s:palette.none)
call s:HL('Red', s:palette.red, s:palette.none)
call s:HL('Orange', s:palette.orange, s:palette.none)
call s:HL('Yellow', s:palette.yellow, s:palette.none)
call s:HL('Green', s:palette.green, s:palette.none)
call s:HL('Blue', s:palette.blue, s:palette.none)
call s:HL('Purple', s:palette.purple, s:palette.none)
call s:HL('RedItalic', s:palette.red, s:palette.none, 'italic')
call s:HL('BlueItalic', s:palette.blue, s:palette.none, 'italic')
call s:HL('OrangeItalic', s:palette.orange, s:palette.none, 'italic')
let s:terminal = {
			\ 'black':s:palette.black,'red':s:palette.red,'yellow':s:palette.yellow,'green':s:palette.green,
			\ 'cyan':s:palette.orange,'blue':s:palette.blue,'purple':s:palette.purple,'white':s:palette.fg
			\ }
let g:terminal_ansi_colors = [s:terminal.black[0], s:terminal.red[0], s:terminal.green[0], s:terminal.yellow[0],
			\ s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0], s:terminal.black[0], s:terminal.red[0],
			\ s:terminal.green[0], s:terminal.yellow[0], s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0]]

