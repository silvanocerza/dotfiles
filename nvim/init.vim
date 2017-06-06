" Start plugins section by specifying plugin directory
call plug#begin('~/.local/share/nvim/plugged')

" Color scheme
Plug 'tomasr/molokai'

" Initializes plugin system
call plug#end()

" Color scheme settings
let g:molokai_original = 1
set termguicolors

" Color scheme
syntax enable
colorscheme molokai

" Clipboard that makes sense
set clipboard+=unnamedplus

" Shows line numbers
set number

" Maps j+k to Esc
imap jk <Esc>

" Number of spaces used when TAB is read from a file 
set tabstop=4

" Number of spaces used when TAB is pressed
set softtabstop=4

" Expands TAB to spaces
set expandtab

" Draws an horizontal line on current line
set cursorline

" Highlights matching parens
set showmatch

" Highlights matching searched chars 
set hlsearch

" Turns off search highlight by pressing leader + space
nnoremap <leader><space> :nohlsearch<CR>
