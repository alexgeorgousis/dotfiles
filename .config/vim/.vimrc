" Save copied text (yy) in clipboard
set clipboard=unnamed

" Syntax highlighting
syntax on

:set splitright

" Enable fzf integration
set rtp+=/usr/local/opt/fzf

" Key maps
imap jk <Esc>
nmap j gj
nmap k gk
nmap H ^
nmap L $
vmap H ^
vmap L $
nmap <C-P> :FZF<CR>

" netrw config
let g:netrw_liststyle = 3     "set tree list view as default for netrw
let g:netrw_banner = 0        "remove top banner
let g:netrw_browse_split = 4  "open files in previous window
let g:netrw_winsize = 25      "set explorer width
let g:netrw_altv=1            "open split view ("v") on the right

" Open terminal in split window and close on exit
map <Leader>t :vertical terminal ++close<cr>
tmap <Leader>t <c-w>:term ++close<cr>

