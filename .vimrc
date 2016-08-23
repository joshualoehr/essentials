syntax on
filetype indent plugin on
set modeline
set background=dark
set splitbelow
set splitright
set hlsearch
set number

let mapleader = "f"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Y y$
nnoremap <Space> :
imap jj <Esc>
nnoremap <S-K> O<Esc>
nnoremap <S-J> o<Esc>
nnoremap <Backspace> hx
nnoremap <Tab> i<Tab><Esc><Right>
nnoremap ;; i;<Esc>
nnoremap <Leader>d :DiffSaved<Enter>
nnoremap <Leader>f<Space> za
nnoremap <Leader>fo zR
nnoremap <Leader>fc zM
nnoremap <Leader>ff za'f
nnoremap <Leader>fi :setlocal foldmethod=indent<Enter>
nnoremap <Leader>fs :setlocal foldmethod=syntax<Enter>
nnoremap <Leader>fm :setlocal foldmethod=manual<Enter>
nnoremap <Leader>' `
nnoremap <Leader>'<Leader>' ``

set foldmethod=indent
set foldcolumn=2
set foldlevel=0
set foldnestmax=3
function! NeatFoldText() 
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()


autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype html setlocal ts=4 sts=4 sw=4
autocmd Filetype txt setlocal ts=4 sts=4 sw=4

set expandtab
set tabstop=4
set shiftwidth=4

fun! FourSpaces() 
	set ts=2 sts=2 noet
	retab!
	set ts=4 sts=4 et
	retab
endfunction
command! Tab4 call FourSpaces()

fun! TwoSpaces() 
	set ts=4 sts=4 noet
	retab!
	set ts=2 sts=2 et
	retab
endfunction
command! Tab2 call TwoSpaces()

function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

inoremap ( ()<Left>
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap { {}<Left>
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap [ []<Left>
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
imap {<Enter> {<Enter><Tab><Enter>}<Up><Right>
imap (<Enter> (<Enter><Tab><Enter>)<Up><Right>
imap [<Enter> [<Enter><Tab><Enter>]<Up><Right>

set backupcopy=yes

autocmd BufEnter * call system("tmux rename-window [" . expand("%:t") . "]")
autocmd VimLeave * call system("tmux rename-window [bash]")
autocmd BufEnter * let &titlestring = ' [' . expand("%:t") . ']'
set title

" VIM PLUG - Auto Install "
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
filetype plugin on

"
" VIM PLUG - Helpers "
"

" Conditional plugin "
" Ex: Plug 'benekastah/neomake', Cond(has('nvim')) 
function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

"
" VIM PLUG - Plugins "
"

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

call plug#end()
