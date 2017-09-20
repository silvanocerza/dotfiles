" Start plugins section by specifying plugin directory
call plug#begin('~/.local/share/nvim/plugged')

" Color scheme
Plug 'tomasr/molokai'

" Auto complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'

" Markdown
Plug 'suan/vim-instant-markdown'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Trim whitespaces
Plug 'ntpeters/vim-better-whitespace'

" Navigation between vim splits and tmux panes
Plug 'christoomey/vim-tmux-navigator'

" Nerdtree
Plug 'scrooloose/nerdtree'

" git
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" Cool icons
Plug 'ryanoasis/vim-devicons'

" Kills buffers without closing windows
Plug 'qpkorr/vim-bufkill'

" Initializes plugin system
call plug#end()

" -------------- Various Settings --------------

" color scheme settings
let g:molokai_original = 1
set termguicolors

" Color scheme
syntax enable
colorscheme molokai

" Sets colored line at specified column
let &colorcolumn="81,".join(range(121,999),",")

" Trims whitespace on save
autocmd BufWritePost * StripWhitespace

" Disables vim backup and swap file
set nobackup
set noswapfile

" Reloads file if it's modified by another source
set autoread

" Clipboard that makes sense
set clipboard+=unnamedplus

" Shows line numbers
set number

" Keeps cursors centered vertically on the screen
set scrolloff=999

" Number of spaces used when tab is read from a file
set tabstop=4

" Number of spaces used when tab is pressed
set softtabstop=4

" Expands tab to spaces
set expandtab

" Number of spaces to use for autoindent
set shiftwidth=4

" Copies indent from the previous line
set autoindent
set copyindent

" Draws an horizontal line on current line
set cursorline

" Highlights matching parens
set showmatch

" Highlights matching searched chars
set hlsearch

" Shows spaces and various non visible chars
set listchars=tab:→\ ,space:·,trail:·
set list

" New splits are added below current window, this is useful mainly for previews
set splitbelow

" Enables mouse selection
set mouse=a

" Neovim python versions
let g:python_host_prog = '/home/alien/.virtualenvs/neovim2/bin/python'
let g:python3_host_prog = '/home/alien/.virtualenvs/neovim3/bin/python'

" NERDTree settings
let g:webdeviconsnerdtreegitpluginforcevalign = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.qmlc$']
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Opens NERDTree automatically when opening vim
autocmd vimenter * NERDTree

" Airline settings
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

" Deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1

" Jedi settings
let g:jedi#completions_enabled = 0 " Disables jedi autocomplete since I use deoplete

" Closes autocomplete preview window when done
autocmd CompleteDone * silent! pclose!

" Supertab settings
let g:SuperTabDefaultCompletionType = "<c-n>"

" Git gutter settings
set signcolumn=yes

" Markdown settings
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0

" -------------- Key Mappings --------------

" Changes leader
let mapleader=';'

" Switches between C++ header and source
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Turns off search highlight by pressing leader + space
nnoremap <leader><space> :nohlsearch<cr>

" Opens nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Maps j+k to esc insert mode
imap jk <esc>

" Quick save and close
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>q :q<CR>

" Switches buffers with tab
nmap <S-Tab> :bprevious!<CR>
nmap <Tab> :bnext!<CR>

" Closes current buffer
nnoremap <leader>bd :BD<CR>
