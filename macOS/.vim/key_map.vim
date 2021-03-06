let mapleader = "\<Space>"
nnoremap ; :
nmap <C-o> :botright copen<CR>
" split系
nnoremap <leader>vsp :vsplit<CR>
nnoremap <leader>sp :split<CR>
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
" command shortcut
nnoremap <leader>ww :w<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>aq :qa<CR>
nnoremap <leader>fq :q!<CR>
nnoremap <leader>afq :qa!<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>d :bd<CR> 
nnoremap <leader><leader> :noh<CR> 
nnoremap <leader>te :call TermOpen()<CR>
function! TermOpen()
    if empty(term_list())
        execute "belowright term"
    else
        call win_gotoid(win_findbuf(term_list()[0])[0])
    endif
endfunction
