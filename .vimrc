" .vimrc "



" Various Vim Settings "
filetype indent plugin on
set modeline
set splitbelow
set splitright
set hlsearch
set incsearch
set number
set wildmenu
set lazyredraw
set showmatch
set backupcopy=yes



" Indentation configurations "
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype typescript setlocal ts=4 sts=4 sw=4
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype html setlocal ts=4 sts=4 sw=4
autocmd Filetype txt setlocal ts=4 sts=4 sw=4
set expandtab
set tabstop=4
set shiftwidth=4



" Syntax Highlighting / Colorschemes "
syntax on
set t_Co=256
"colorscheme oceanblack256
"colorscheme bubblegum-256-dark
"colorscheme gotham256
"colorscheme xoria256
colorscheme seoul256
highlight Normal ctermbg=black



" Pathogen "
set nocp
execute pathogen#infect()



" Keybindings "
" Custom Leader set to 'f' "
let mapleader = "f"
" Leader shortcuts "
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
" Other keybindings "
nnoremap <Space> :
imap jj <Esc>
imap \' `
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Y y$
nnoremap <S-K> O<Esc>
nnoremap <S-J> o<Esc>
nnoremap <Backspace> hx
nnoremap <Tab> i<Tab><Esc><Right>
nnoremap ;; i;<Esc>
" Autocompletion of parentheses/brackets/braces "
inoremap ( ()<Left>
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap { {}<Left>
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap [ []<Left>
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
imap {<Enter> {<Enter><Tab><Enter>}<Up><Right>
imap (<Enter> (<Enter><Tab><Enter>)<Up><Right>
imap [<Enter> [<Enter><Tab><Enter>]<Up><Right>



" Custom Functions "
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()



" Tmux Things "
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

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

call plug#end()
