set number " 行表示-
set showmatch " 括弧の対応づけ
" indent setting
set expandtab
set tabstop=4
set shiftwidth=4
set noautoindent
set nosmartindent
set noundofile " .un~という謎ファイル要らない
set clipboard=unnamed,autoselect " clip board 
syntax on
colorscheme vimbrains "Color Scheme
" Command Alias------------------------------
:command Nt NERDTree
" Command key mapping------------------------
nmap <C-o> :copen<CR>
nmap <F7> :Ag<CR>
nmap <C-f> :CtrlPLine<CR>
nmap <C-g> :FlyGrep<CR>
nmap <C-h> :Rgrep<CR>
nmap <F8> :Tagbar<CR>
nmap <C-n> :NERDTreeToggle<CR>
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
"grep.vi,
if executable('ag') " require ag
      let g:Fgrep_Path='/usr/local/bin/ag'
      let g:Grep_Path='/usr/local/bin/ag'
endif
let g:Grep_Null_Device = '/dev/null'
"ctrlp---------------------------------------
if executable('ag') " require ag
      let g:ctrlp_use_caching=0
      let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif
"JavaScript----------------------------------
let g:jscomplete_use = ['dom', 'moz', 'es6th']
let g:syntastic_javascript_jslint_conf = "--white --undef --nomen --regexp --plusplus --bitwise --newcap --sloppy --vars"
" airline----------------------------------------
let g:airline_powerline_fonts = 1
"nere tree----------------------------------------
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 起動時にディレクトリならNERDTree、ファイルならファイルにフォーカスをあてる
let g:nerdtree_tabs_smart_startup_focus=1
" 新規タブを開いた時にもNERDTreeを表示する
let g:nerdtree_tabs_open_on_new_tab=1
" 不可視ファイルを表示する
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrows = 1
"vim-devicons(require nerd fonts)----------------------------------------
let NERDTreeWinSize=22
let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
" vim-devicons
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
" dir-icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
"neco----------------------------------------
let g:acp_enableAtStartup = 0 " Disable AutoComplPop.
let g:neocomplcache_enable_at_startup = 1 " Use neocomplcache.
let g:neocomplcache_enable_smart_case = 1 " Use smartcase.
let g:neocomplcache_min_syntax_length = 3 " Set minimum syntax keyword length.
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }
" gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'javascript',
    \ 'kinds'     : [
        \ 'c:classes:0:1',
        \ 'o:object:0:0',
        \ 'f:functions:0:1',
        \ 'm:methods:0:1',
        \ 'p:properties:0:0',
        \ 'v:global variables:0:0',
        \ 'r:variables:0:0',
    \ ],
\ }

" gocode
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
" neco key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
"set snippet file dir
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/,~/.vim/snippets'
"scroloose/syntastic---------------------------
let g:syntastic_mode_map = { 'mode': 'passive',
    \ 'active_filetypes': ['go'] }
"let g:syntastic_go_checkers = ['golint']
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
"let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['vet', 'golint']
"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim
" Required:
call neobundle#begin(expand('~/vagrant/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" NeoBundle my dependency------------------------------------
" ------ Vim
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'vim-syntastic/syntastic'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle "ctrlpvim/ctrlp.vim"
NeoBundle 'rking/ag.vim'
NeoBundle 'wsdjeg/FlyGrep.vim'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'mattn/vim-terminal'
" ------ Go
NeoBundleLazy 'fatih/vim-go', { 'autoload' : { 'filetypes' : 'go'  } }
NeoBundleLazy 'vim-jp/vim-go-extra', { 'autoload' : { 'filetypes' : 'go'  } }
" ------ JavaScript
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'mattn/jscomplete-vim'
NeoBundle 'ternjs/tern_for_vim'
" ------ python
NeoBundle 'python-mode/python-mode'
" ------ syntax checker
NeoBundle 'scrooloose/syntastic'
" -----------------------------------------------

" Required:
call neobundle#end()
" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------
