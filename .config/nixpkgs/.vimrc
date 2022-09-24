" --------------------------------
" Basic settings
" --------------------------------

" Save copied text (yy) in clipboard
" Note: Unfortunately this breaks copying with vim enabled in home-manager
" (feel free to test if this is still the case)
" set clipboard=unnamed

set number      " Show line numbers
set splitright  " Open vertical splits to the right
set mouse=a     " Enable mouse drag on window splits

" Cursor style: block in normal mode and line in insert mode 
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" --------------------------------
" Key maps
" --------------------------------

imap jk <Esc>
nmap j gj
nmap k gk
nmap H ^
nmap L $
vmap H ^
vmap L $
nmap <C-P> :FZF<CR>


" --------------------------------
" Terminal
" --------------------------------

" \+t opens terminal in split window
map <Leader>t :vertical terminal ++close<cr>

" Close terminal pane on exit
tmap <Leader>t <c-w>:term ++close<cr>


" --------------------------------
" netrw
" --------------------------------

let g:netrw_liststyle = 3     " Set tree list view as default for netrw
let g:netrw_banner = 0        " Remove top banner
let g:netrw_browse_split = 4  " Open files in previous window
let g:netrw_winsize = 25      " Set explorer width
let g:netrw_altv=1            " Open split view ("v") on the right

