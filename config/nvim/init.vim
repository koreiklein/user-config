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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/node_modules/*,dist/*
set cc=120                  " set an 80 column border for good coding style
set ttyfast                 " We are always going to be using a fast terminal.
set undofile                " Maintain undo history between sessions
set showtabline=0
filetype plugin on          " detect filetypes

set timeoutlen=1000 ttimeoutlen=10     " 50 milliseconds for esc timeout instead of 1000

nmap t <Plug>Lightspeed_s
nmap T <Plug>Lightspeed_S
vmap t <Plug>Lightspeed_s
vmap T <Plug>Lightspeed_S

" Because the i key broke at one point.
imap <c-u> i

filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vundle/Vundle.vim
call vundle#begin('~/.vundle/')

Plugin 'tpope/vim-fugitive' " For interacting with git from within vim
" Plugin 'jremmen/vim-ripgrep'

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim' " Use vundle
Plugin 'scrooloose/nerdtree' " filesystem explorer
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'christoomey/vim-tmux-navigator' " To navigate vim windows like tmux windows
Plugin 'vim-airline/vim-airline' " A better better status bar
Plugin 'vim-airline/vim-airline-themes' " Themes for airline
Plugin 'tomtom/tcomment_vim' " gc to comment/uncomment lines
" Plugin 'Vimjas/vim-python-pep8-indent'
" Plugin 'neoclide/coc.nvim' " LSP support
Plugin 'neovim/nvim-lspconfig'
Plugin 'hrsh7th/cmp-nvim-lsp'
Plugin 'hrsh7th/cmp-buffer'
Plugin 'hrsh7th/cmp-path'
Plugin 'hrsh7th/cmp-cmdline'
Plugin 'hrsh7th/nvim-cmp'

" cmp-vsnip integration
Plugin 'hrsh7th/cmp-vsnip'
Plugin 'hrsh7th/vim-vsnip'
Plugin 'rafamadriz/friendly-snippets' " Commen snippets for a variety of popular languages

" Telescope section.  Telescope is for opening files
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plugin 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plugin 'tpope/vim-obsession' " Required for xtabline
"Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plugin 'junegunn/fzf.vim' " Required for xtabline
Plugin 'mg979/vim-xtabline' " Another way to show buffers at the top

Plugin 'editorconfig/editorconfig-vim' " Understand and follow the rules in editorconfig files
Plugin 'sjl/badwolf' " A nice colorscheme
Plugin 'let-def/vimbufsync' " Needed for coquille
Plugin 'trefis/coquille.git' " For coq
Plugin 'derekwyatt/vim-scala'
Plugin 'zchee/vim-flatbuffers' " For editng google flatbuffer files
Plugin 'majutsushi/tagbar' " ctags integration in a sidebar
Plugin 'alfredodeza/pytest.vim' " pytest integration
Plugin 'leafgarland/typescript-vim' " typescript syntax highlighting
Plugin 'jason0x43/vim-js-indent' " for javascript and typescript
Plugin 'ludovicchabant/vim-gutentags.git'
Plugin 'Olical/conjure' " project for evaluating clojure as you code
Plugin 'guns/vim-sexp' " s-exp editing support

Plugin 'ggandor/lightspeed.nvim' " For moving the cursor elsewhere on the screen using very few keystrokes

" devicons wants to be loaded next to last, and devicons-emoji must be loaded after it
Plugin 'ryanoasis/vim-devicons'
Plugin 'adelarsq/vim-devicons-emoji'

" NOTE: vim-latex depends on imaps.vim which is known to cause problems with
" C-j
" Plugin 'vim-latex/vim-latex' " LaTex

" All of your Plugins must be added before the following line
call vundle#end()

" s-expr extensions.
" Inspired by https://github.com/tpope/vim-sexp-mappings-for-regular-people/blob/master/plugin/sexp_mappings_for_regular_people.vim
function! s:map_sexp_wrap(type, target, left, right, pos)
  execute (a:type ==# 'v' ? 'x' : 'n').'noremap'
        \ '<buffer><silent>' a:target ':<C-U>let b:sexp_count = v:count<Bar>exe "normal! m`"<Bar>'
        \ . 'call sexp#wrap("'.a:type.'", "'.a:left.'", "'.a:right.'", '.a:pos.', 0)'
        \ . '<Bar>silent! call repeat#set("'.a:target.'", v:count)<CR>'
endfunction

call s:map_sexp_wrap('e', 'cseb', '(', ')', 0)
call s:map_sexp_wrap('e', 'cse(', '(', ')', 0)
call s:map_sexp_wrap('e', 'cse)', '(', ')', 1)
call s:map_sexp_wrap('e', 'cse[', '[', ']', 0)
call s:map_sexp_wrap('e', 'cse]', '[', ']', 1)
call s:map_sexp_wrap('e', 'cse{', '{', '}', 0)
call s:map_sexp_wrap('e', 'cse}', '{', '}', 1)


" LSP setup for clojure
" see
" https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
" for how to configure new lsp servers
lua << EOF
require'lspconfig'.clojure_lsp.setup{}
require'lspconfig'.tsserver.setup{}
EOF

" LSP bindings
"
nnoremap go <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ge <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap gf <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap ga <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap ga <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gk <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gR <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>



filetype plugin indent on  " allows auto-indenting depending on file type
nmap <Space> :
vmap <Space> :
imap <Tab> <C-n>
nmap [g :res -5<cr>
nmap [c :res -1<cr>
nmap [r :res +1<cr>
nmap [l :res +5<cr>

autocmd FileType tex map gl :!pdflatex %<cr>
autocmd FileType tex inoremap ^ ^{}<left>
autocmd FileType tex inoremap _ _{}<Left>
autocmd FileType tex inoremap $$ \[<cr><cr>\]<Left><Left><Up><space><space>
autocmd FileType tex inoremap { {}<Left>
autocmd FileType tex inoremap ( ()<Left>

"
let g:syntastic_tex_checkers = ['lacheck']
" 
" let g:syntastic_python_pylint_exe = 'python -m pylint3'

let g:BASH_Ctrl_j = 'off'
let g:ZSH_Ctrl_j = 'off'


set ts=2
set tabstop=2     " Tab characters = 8 spaces when displayed
set shiftwidth=2  " Use 4 spaces for each insertion of (auto)indent
set softtabstop=2 " Tabs 'count for' 4 spaces when editing (fake tabs)
set expandtab     " <tab> -> spaces in insert mode

" Shift highlighted region left or right
vmap <Tab> >gv
vmap <S-Tab> <gv

set hidden
tnoremap <Esc> <C-\><C-n>

let g:xtabline_settings = {}
let g:xtabline_settings.bufline_numbers = 0
let g:xtabline_settings.bufline_format = 'l+ '
let g:xtabline_settings.bufline_indicators = {
      \ 'modified': ' 𝛅',
      \ 'readonly': '🔒 ',
      \ 'scratch': '[!]',
      \ 'pinned': '📌',
      \}

" nnoremap ) :bnext<CR>
" nnoremap ( :bprev<CR>
"
nnoremap ) :XTabNextBuffer<CR>
noremap g) :XTabMoveBufferNext<CR>
nnoremap ( :XTabPrevBuffer<CR>
noremap g( :XTabMoveBufferPrev<CR>
noremap gx :XTabCloseBuffer<CR>:XTabCleanUp<CR>

" let g:xtabline_settings.tabline_modes = ['tabs', 'buffers', 'arglist']
let g:xtabline_settings.tabline_modes = ['buffers']

colorscheme badwolf

" NeoMake configuration
" call neomake#configure#automake('w') " When writing a buffer.
" call neomake#configure#automake('nw', 750) " When writing a buffer, and on normal mode changes (after 750ms).
" call neomake#configure#automake('rw', 1000) " When reading a buffer (after 1s), and when writing.

let g:neomake_open_list = 2

set noshowmode " Arline already shows the mode
let g:airline_theme='luna'

let g:python_host_prog='/usr/local/bin/python3'
let g:python3_host_prog='/usr/local/bin/python3'

let g:neomake_python_enabled_makers = ['mypy', 'flake8']
let g:neomake_tex_enabled_makers = ['lacheck']

autocmd BufReadPost,BufNewFile *.log set nowrap

" LPS auto import on save for golang files
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

let g:ycm_server_python_interpreter = '/usr/local/bin/python3'

nmap gb :TagbarToggle<CR>
nmap gn :NERDTree<CR>
let g:airline#extensions#tabline#enabled = 1

autocmd BufReadPost,BufNewFile *.py,*.cpp,*.hpp :TagbarOpen


let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
" let g:airline_left_alt_sep = '▶'
" let g:airline_right_alt_sep = '◀'
"
let g:CtrlSpaceDefaultMappingKey = "<C-space> "

" let g:tagbar_left = 1


au BufNewFile,BufRead *.xaml        setf xml
" au BufReadPost,BufNewFile *.v :CoqLaunch<cr>
"
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>

tnoremap <silent> <C-h> <C-\><C-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
tnoremap <silent> <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
tnoremap <silent> <C-t> <C-\><C-n>:TmuxNavigateRight<cr>

"nnoremap gr :make\|copen<cr>

lua << EOF
  require('telescope').setup {
    pickers = {
      find_files = {
        theme = "ivy"
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }
  }
  require('telescope').load_extension('fzf')
EOF


let maplocalleader = ","
noremap <localleader>gl <cmd>lua require('telescope.builtin').find_files()<cr>
noremap <localleader>cl <cmd>lua require('telescope.builtin').live_grep()<cr>
noremap <localleader>rl <cmd>lua require('telescope.builtin').buffers()<cr>

"map ,l :Telescope help_tags<cr>


"map <c-g> :CtrlP<cr>
"map <c-n> :CtrlPBuffer<cr>
map cpf :Eval<cr>


autocmd FileType cpp noremap <buffer> <c-f> :call Uncrustify('cpp')<CR>
autocmd FileType cpp vnoremap <buffer> <c-f> :call RangeUncrustify('cpp')<CR>

"" enable deoplete
let g:deoplete#enable_at_startup = 0
" autocmd FileType

autocmd FileType typescript let g:ycm_auto_trigger=1

let g:ctrlp_custom_ignore = 'node_modules/\|dist/\|target\|_site'

if !exists("g:ycm_semantic_triggers")
let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" tagbar typescript configuration
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

let g:gutentags_cache_dir = '~/.gutentags'

let g:sexp_mappings = {
      \ 'sexp_move_to_prev_bracket':      '=(',
      \ 'sexp_move_to_next_bracket':      '=)',
      \ }

let g:clojure_syntax_keywords = {
    \ 'clojureMacro': ["defn-change", "case-change", "deftest", "testing", "is", "s/fdef", "s/def", "try-let", "misc/defmemo", "defmemo", "q/dz-fn", "q/dz-quote"],
    \ 'clojureFunc': ["s/keys", "s/and", "s/or", "s/cat", "s/merge", "s/coll-of", "s/map-of", "s/tuple", "s/alt", "s/*", "s/?"],
    \ 'clojureException': ["throw+", "try+"]
    \ }

" Use deoplete for autocompletion
let g:deoplete#enable_at_startup = 0

syntax enable
" LSC configuration
set shortmess-=F
" Use all the lsc (language server protocol) keybinding
" let g:lsc_auto_map = v:true
" let g:lsc_server_commands = { 
"       \'scala': "start-dotty-ide"
"       \ }

" let g:neomake_java_javac_args = ['-cp', '/Users/koreiklein/.lein/self-installs/leiningen-2.9.1-standalone.jar:~/.m2/repository/*']
"
"
let g:tex_flavor = 'latex'

let g:ale_linters = {
      \ 'scala': ['scalastyle'],
      \ }

" Folding via LSP support for vim
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" vsnip mappings
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


" nvim-cmp autocmpletion setup from https://github.com/hrsh7th/nvim-cmp/
set completeopt=menu,menuone,noselect



lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', { sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }) })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  --  require('lspconfig')['<YOUR_LSP_SERVER>'].setup { capabilities = capabilities }
EOF
