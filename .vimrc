syntax on
filetype indent plugin on
set modeline
set background=dark
set splitbelow
set splitright
set hlsearch
set number
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
nnoremap <Tab> i<Tab><Esc>
nnoremap ;; i;<Esc>

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
