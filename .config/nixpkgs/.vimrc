" --------------------------------
" Basic settings
" --------------------------------

" Save copied text (yy) in clipboard
" Note: Unfortunately this breaks copying with vim enabled in home-manager
" (feel free to test if this is still the case)
" set clipboard=unnamed

set number      " Show line numbers
set splitbelow  " Open horizontal splits below
set splitright  " Open vertical splits to the right
set mouse=a     " Enable mouse drag on window splits

" Cursor style: block in normal mode and line in insert mode 
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" --------------------------------
" Basic key maps
" --------------------------------

imap jk <Esc>
nmap j gj
nmap k gk
nmap H ^
nmap L $
vmap H ^
vmap L $
let mapleader = " "  " Map Leader key to Space


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


" --------------------------------
" FZF
" --------------------------------
"  GitHub repo: https://github.com/junegunn/fzf.vim/

" Search window position
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.25, 'relative': v:true, 'yoffset': -1.0 } }

" Map Ctrl-P to FZF file search
nmap <C-P> :FZF<CR>


" --------------------------------
" CtrlSF
" --------------------------------
"  See full list of configuration options: https://github.com/dyng/ctrlsf.vim#configuration 

" Don't close search window when opening file
  " 'normal' refers to ctrlsf normal (as opposed to compact) window mode
let g:ctrlsf_auto_close = { "normal": 0 }

" Automatically focus results window when search begins
let g:ctrlsf_auto_focus = { "at": "start" }

" Automatically focus results window when search begins
let g:ctrlsf_winsize = "25%"

" Adds :CtrlSF to the command line
nmap <C-F>f <Plug>CtrlSFPrompt

" Searches the currently highlighted word
vmap <C-F>f <Plug>CtrlSFVwordExec

" Searches the word under the cursor
nmap <C-F>n <Plug>CtrlSFCwordExec

" Opens last search results window (without re-executing search)
nnoremap <C-F>o :CtrlSFOpen<CR>

" Toggle last search results window in normal mode and insert mode
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

