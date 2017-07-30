" 行表示-------------------------------------
set number
" 括弧の対応づけ-----------------------------
set showmatch
" インデントとか-----------------------------
set expandtab
set tabstop=2
set shiftwidth=2
set noautoindent
set nosmartindent
" クリップボード-----------------------------
set clipboard=unnamed,autoselect
"Color Scheme--------------------------------
syntax on
"colorscheme molokai
"colorscheme moonfly
colorscheme vimbrains
"colorscheme vorange
"colorscheme contrastneed
"colorscheme srcery-drk
"--------------------------------------------
" Command Alias-----------------------------------
:command Ufb Unite file buffer
:command Nt NERDTree
"JavaScript----------------------------------
let g:jscomplete_use = ['dom', 'moz', 'es6th']
let g:syntastic_javascript_jslint_conf = "--white --undef --nomen --regexp --plusplus --bitwise --newcap --sloppy --vars"
"neco----------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
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

" gocode
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
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
"neco------------------------------------------


"scroloose/syntastic---------------------------
let g:syntastic_mode_map = { 'mode': 'passive',
    \ 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']

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
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'vim-syntastic/syntastic'
NeoBundle 'scrooloose/nerdtree'
NeoBundle "ctrlpvim/ctrlp.vim"
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'vim-airline/vim-airline'
" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
" ------ Go
NeoBundleLazy 'fatih/vim-go', { 'autoload' : { 'filetypes' : 'go'  } }
NeoBundleLazy 'vim-jp/vim-go-extra', { 'autoload' : { 'filetypes' : 'go'  } }
" ------ JavaScript
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'mattn/jscomplete-vim'
" ------ markdown
NeoBundle 'plasticboy/vim-markdown'
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
