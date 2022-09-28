" ----------------------------------------------------------------
" Basic settings
" ----------------------------------------------------------------

" Save copied text (yy) in clipboard
" Note: Unfortunately this breaks copying with vim enabled in home-manager
" (feel free to test if this is still the case)
" set clipboard=unnamed

set number      " Show line numbers
set splitbelow  " Open horizontal splits below
set splitright  " Open vertical splits to the right
set mouse=a     " Enable mouse drag on window splits
set noswapfile  " Don't create swap (.swp) files

" Set tab to 2 spaces
" Good article explaining tab settings in vim:
" https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990
set tabstop=2      " Length of \t char 
set shiftwidth=2   " Length of 1 level of indentation
set softtabstop=2  " Length of tab and backspace keypresses 

" Set indentation for python files (you can use ftypes plugin to more easily manage multiple languages)
au BufNewFile,BufRead *.py
			\ set tabstop=4       |
			\ set softtabstop=4   |
			\ set shiftwidth=4    |
			\ set textwidth=79    |
			\ set expandtab       |
			\ set autoindent      |
			\ set fileformat=unix |

" Cursor style: block in normal mode and line in insert mode 
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" ----------------------------------------------------------------
" Basic key maps
" ----------------------------------------------------------------

let mapleader = " "
imap jk <Esc>
nmap j gj
nmap k gk
nmap H ^
nmap L $
vmap H ^
vmap L $
nmap Y y$

" Window navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l


" ----------------------------------------------------------------
" Terminal
" ----------------------------------------------------------------

" \+t opens terminal in split window
map <Leader>t :vertical terminal ++close<cr>

" Close terminal pane on exit
tmap <Leader>t <c-w>:term ++close<cr>


" ----------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------

let g:NERDTreeShowHidden=1  " Show hidden files
let g:NERDTreeWinSize=40    " Set window width
let g:NERDTreeMinimalUI=1   " Remove help message at the top

" If file in open buffer changes name or path, automatically replace file in buffer with new file
let g:NERDTreeAutoDeleteBuffer=1  

" Map <Leader>n to the following:
" if NERDTree is already open, close it
" else if a file is open in the current buffer, open NERDTree with said file highlighted
" else open NERDTree
nnoremap <silent> <expr> <Leader>n 
			\ g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" :
			\ bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"


" ----------------------------------------------------------------
" FZF
" ----------------------------------------------------------------
"  GitHub repo: https://github.com/junegunn/fzf.vim/

" Search window position
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.25, 'relative': v:true, 'yoffset': -1.0 } }

" Map Ctrl-P to FZF file search
nmap <C-P> :FZF<CR>


" ----------------------------------------------------------------
" CtrlSF
" ----------------------------------------------------------------
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

