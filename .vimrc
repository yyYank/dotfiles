" indent setting ========================================
set expandtab
set tabstop=4
set shiftwidth=4
set noautoindent
set nosmartindent
" general setting =======================================
set number " 行表示
set showmatch " 括弧の対応づけ
setlocal iskeyword+=-
set noundofile " .un~という謎ファイル要らない
set backspace=indent,eol,start " mac の呪い
set clipboard=unnamed,autoselect " clip board 
" rtp ===================================================
set rtp+=$GOROOT/misc/vim
set rtp+=~/.fzf
syntax on
" Cursor ================================================
set cursorline
hi CursorLine term=bold cterm=bold ctermbg=237
hi CursorLineNr term=bold cterm=NONE ctermfg=228 ctermbg=237
" モードごとのカーソル設定
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
" insertモードに入ったらカーソルハイライトクリア
autocmd InsertEnter * hi clear CursorLine
" insertモードを抜けたらカーソルハイライト
autocmd InsertLeave * hi CursorLine term=bold cterm=bold ctermbg=237
" completion setting =====================================
autocmd InsertLeave * :pclose
autocmd FileType qf wincmd J
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" For conceal markers====================================
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" key mapping============================================
if filereadable(expand('$HOME/.vim/key_map.vim'))
  source $HOME/.vim/key_map.vim
endif
" load dein =============================================
if filereadable(expand('$HOME/.vim/dein/dein_init.vim'))
  source $HOME/.vim/dein/dein_init.vim
endif
colorscheme afterglow
