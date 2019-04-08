set number " 行表示
set showmatch " 括弧の対応づけ
setlocal iskeyword+=-
" indent setting
set expandtab
set tabstop=4
set shiftwidth=4
set noautoindent
set nosmartindent
set noundofile " .un~という謎ファイル要らない
set clipboard=unnamed,autoselect " clip board 
set rtp+=$GOROOT/misc/vim
set rtp+=~/.fzf
" mac の呪い
set backspace=indent,eol,start
syntax on
" colorscheme vimbrains "Color Scheme
" Command key mapping------------------------
nnoremap ; :
nmap <C-o> :botright copen<CR>
" カーソルのハイライト設定
set cursorline
hi CursorLine term=bold cterm=bold ctermbg=237
" モードごとのカーソル設定
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
" insertモードを抜けたらpopupは閉じる
autocmd InsertLeave * :pclose
" insertモードに入ったらカーソルハイライトクリア
autocmd TextChangedI * hi clear CursorLine
" insertモードを抜けたらカーソルハイライト
autocmd InsertLeave * hi CursorLine term=bold cterm=bold ctermbg=237
autocmd FileType qf wincmd J
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
let mapleader = "\<Space>"
 
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set rtp+=/Users/yy_yank/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/yy_yank/.vim/dein')
  call dein#begin('/Users/yy_yank/.vim/dein')
  " toml
  let s:toml_dir  = $HOME . '/.vim/dein/toml' 
  let s:toml      = s:toml_dir . '/dein.toml'
  let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
