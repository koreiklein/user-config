set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets.
set ignorecase              " Do case insensitive matching
set mouse=v                 " middle-click paste with mouse
set encoding=utf-8          " Display Unicode Characters
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/node_modules/*
set cc=120                  " set an 80 column border for good coding style
set ttyfast                 " We are always going to be using a fast terminal.
set undofile                " Maintain undo history between sessions
filetype plugin on          " detect filetypes

set timeoutlen=1000 ttimeoutlen=10     " 50 milliseconds for esc timeout instead of 1000

filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vundle/Vundle.vim
call vundle#begin('~/.vundle/')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim' " Use vundle
Plugin 'neomake/neomake' " For linting (and generally running background make-like jobs)
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy file finder
Plugin 'christoomey/vim-tmux-navigator' " To navigate vim windows like tmux windows
" Plugin 'itchyny/lightline.vim' " a better status bar
Plugin 'vim-airline/vim-airline' " A better better status bar
Plugin 'vim-airline/vim-airline-themes' " Themes for airline
Plugin 'tomtom/tcomment_vim' " gc to comment/uncomment lines
Plugin 'airblade/vim-gitgutter' " Display marks relevant to git changes
Plugin 'Valloric/YouCompleteMe' " Nice autocomplete
Plugin 'ap/vim-buftabline' " Show buffers at the top
Plugin 'editorconfig/editorconfig-vim' " Understand and follow the rules in editorconfig files
Plugin 'tpope/vim-fugitive' " For interacting with git from within vim
Plugin 'sjl/badwolf' " A nice colorscheme
Plugin 'let-def/vimbufsync' " Needed for coquille
Plugin 'trefis/coquille.git' " For coq
Plugin 'fatih/vim-go' " For golang
Plugin 'jodosha/vim-godebug' " For debugging golang source

" Plugin 'vim-syntastic/syntastic' " 

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on  " allows auto-indenting depending on file type
nmap <Space> :
vmap <Space> :

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_pylint_exe = 'python3 -m pylint3'

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-t> :TmuxNavigateRight<cr>

tnoremap <silent> <C-h> <C-\><C-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
tnoremap <silent> <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
tnoremap <silent> <C-t> <C-\><C-n>:TmuxNavigateRight<cr>

map <c-g> <c-p>

set ts=2
set tabstop=2     " Tab characters = 8 spaces when displayed
set shiftwidth=2  " Use 4 spaces for each insertion of (auto)indent
set softtabstop=2 " Tabs 'count for' 4 spaces when editing (fake tabs)
set expandtab     " <tab> -> spaces in insert mode

" Shift highlighted region left or right
vmap <Tab> >gv
vmap <S-Tab> <gv

set hidden
nnoremap ) :bnext<CR>
nnoremap ( :bprev<CR>
tnoremap <Esc> <C-\><C-n>

colorscheme badwolf

" NeoMake configuration
call neomake#configure#automake('w') " When writing a buffer.
call neomake#configure#automake('nw', 750) " When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('rw', 1000) " When reading a buffer (after 1s), and when writing.

let g:airline_theme='jellybeans'
" let g:airline_powerline_fonts=1 " For arrows in the airline

let g:python_host_prog='/usr/local/bin/python3'
let g:python3_host_prog='/usr/local/bin/python3'

" au BufReadPost,BufNewFile *.v :CoqLaunch<cr>
