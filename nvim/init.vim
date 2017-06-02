" Shows line numbers
:set number

" Maps j+k to Esc
:imap jk <Esc>

" Enables syntax highlight
:syntax enable

" Number of spaces used when TAB is read from a file 
:set tabstop=4

" Number of spaces used when TAB is pressed
:set softtabstop=4

" Expands TAB to spaces
:set expandtab

" Draws an horizontal line on current line
:set cursorline

" Highlights matching parens
:set showmatch

" Highlights matching searched chars 
:set hlsearch

" Turns off search highlight by pressing leader + space
:nnoremap <leader><space> :nohlsearch<CR>
