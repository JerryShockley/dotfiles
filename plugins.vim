" This file is sourced by init.vim. It contains the
" list of plugins along with all plugin related functions,
" Commands, and key mappings.

" Install vim-plug if it isn't already installed
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
    let plugurl = '"https://raw.githubusercontent.com/' .
        \'junegunn/vim-plug/master/plug.vim"'
    let plugdir = stdpath('data') . '/site/autoload/plug.vim'  
   silent execute '!curl -fLo '. plugdir .' --create-dirs '. plugurl  
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin(g:plugged_dir)


let g:plug_shallow = 0
" -- Tech Integration Plugs

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" -- Display/Misc Plugs
"  Make terminal vim and tmux work better together.
" Plug 'tmux-plugins/vim-tmux-focus-events'

" Enables live previews of markdown files
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}


" -- Search Plugs
" easily search for, substitute, and abbreviate multiple variants of a word 
Plug 'tpope/vim-abolish'
"
" Vim utility scripts

" Status line display.  Requires vim-fugitive.
" Plug 'itchyny/lightline.vim'

" -- Editing Plugs

" Comment stuff out.
Plug 'tpope/vim-commentary'
" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'
" Remaps . in a way that plugins can tap into it.
Plug 'tpope/vim-repeat'
" Mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround'
" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'
" Helps to end certain structures automatically.
Plug 'tpope/vim-endwise'
" Shows a git diff in the 'gutter'
Plug 'airblade/vim-gitgutter'
" Manage sessions
Plug 'tpope/vim-obsession'
" Manages many git functions from within vim
Plug 'tpope/vim-fugitive'
" UNIX helpers
Plug 'tpope/vim-eunuch'

" -- Navigation Plugs
" Quickly and easily switch between buffers.
Plug 'jlanzarotta/bufexplorer'
" Command line fuzzy finder installed via Homebrew
Plug '/usr/local/opt/fzf'
" Vim functions to use fzf to search vim lists (e.g. buffers, marks, etc)
Plug 'junegunn/fzf.vim'
" Use your favorite grep tool to start an asynchronous search
Plug 'mhinz/vim-grepper'
" Add some sugar to netrw
Plug 'tpope/vim-vinegar'
" Auto tag file regeneration
Plug 'ludovicchabant/vim-gutentags'

" -- General Programming Language Support

" asynchronous build and test dispatcher
" Plug 'tpope/vim-dispatch'
" Multilanguage vim test runner
Plug 'janko-m/vim-test'
" A collection of Programming Language Packs for most languagesk40
Plug 'sheerun/vim-polyglot'
" Asynchronous linting and make framework for Neovim/Vim
Plug 'neomake/neomake' 
" Dark powered asynchronous completion framework for neovim/Vim8
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } 
" Tiny replacement for Supertab
Plug 'neitanod/vim-clevertab'
" neo-snippet plugin contains neocomplcache snippets source
Plug 'Shougo/neosnippet.vim'
" The standard snippets repository for neosnippet
Plug 'Shougo/neosnippet-snippets'
" Run a command and show it's results quickly
Plug 'thinca/vim-quickrun'

" -- Elixir/Phoenix Language Support

" uses alchemist-server to give inside information 
" about your elixir project in vim.
Plug 'slashmili/alchemist.vim'
" Elixir web development framework
Plug 'c-brenn/phoenix.vim'
" Project config using projections
Plug 'tpope/vim-projectionist'

" -- Javascript Language Support

" Exposes additional tern functionality inside nvim
" such as :TernDefPreview
" Plug ternjs/tern_for_vim
" deoplete.nvim source for javascript
" FT Plugin for Javascript and JSX
Plug 'othree/yajs.vim' 
" Syntax for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'neoclide/vim-jsx-improve'
" Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] } 
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Personal Wiki
Plug 'vimwiki/vimwiki'

" -- Color Schemes
" Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'

call plug#end()



"" ===============================================

""    PLUGIN Configs

"" ===============================================

let g:jsx_ext_required = 1

"" -->  vim-grepper

let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg'] 
let g:grepper.jump = 1

" let g:grepper.

" Search for current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
"
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

call SetupCommandAlias("grep", "GrepperGrep")
call SetupCommandAlias("git", "GrepperGit")
call SetupCommandAlias("rg", "GrepperRg")


"" --> vim-clevertab
inoremap <silent><tab> <c-r>=CleverTab#Complete('start')<cr>
                      \<c-r>=CleverTab#Complete('tab')<cr>
                      \<c-r>=CleverTab#Complete('neosnippet')<cr>
                      \<c-r>=CleverTab#Complete('keyword')<cr>
                      \<c-r>=CleverTab#Complete('omni')<cr>
                      \<c-r>=CleverTab#Complete('deoplete')<cr>
                      \<c-r>=CleverTab#Complete('stop')<cr>
inoremap <silent><s-tab> <c-r>=CleverTab#Complete('prev')<cr>

"" --> deoplete

let new_rtp_path = &rtp.g:plugged_dir.'/deoplete.nvim'
let &rtp=new_rtp_path
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


"" -->  markdown-preview.nvim"
" set to 1, the nvim will open the preview window once enter the markdown buffer
" default: 0
let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it just can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server only listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle'
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'



"" --> vim-test

let test#strategy = 'neomake'

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<C-R>

"" --> NeoMake
" Run make when we save a buffer
if exists('neomake#configure#automake')
    call neomake#configure#automake('rw', 750)
endif

let g:neomake_elixir_enabled_makers = ['mix']
let g:neomake_open_list = 2
let g:quickfixsigns_protect_sign_rx = '^neomake_'
let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_verbose = 3
" let g:neomake_logfile = '/users/jerrys/src/elixir/prototypes/issues/nmake.log'


"" --> FZF
nnoremap <C-p> :<C-u>FZF<CR>

"" --> LightLine status line
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \   'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ ['syntastic', 'lineinfo'],
      \              ['percent'],
      \              ['fileformat', 'fileencoding', 'filetype'] ], 
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }


"" --> NeoSnippet
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)



" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Tern 
" Set bin if you have many instalations
" let g:deoplete#sources#ternjs#tern_bin = '/path/to/tern_bin'
" let g:deoplete#sources#ternjs#timeout = 1

" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for 
" properties) between the completions and the origin position in the result 
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
" Default: 0
let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the 
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0

" Whether to use a case-insensitive compare between the current word and 
" potential completions. Default 0
let g:deoplete#sources#ternjs#case_insensitive = 1

" When completing a property and no completions are found, Tern will use some 
" heuristics to try and return some properties anyway. Set this to 0 to 
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 0

" Determines whether the result set will be sorted. Default: 1
let g:deoplete#sources#ternjs#sort = 0

" When disabled, only the text before the given position is considered part of 
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
let g:deoplete#sources#ternjs#expand_word_forward = 0

" Whether to ignore the properties of Object.prototype unless they have been 
" spelled out by at least two characters. Default: 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0

" Whether to include JavaScript keywords when completing something that is not 
" a property. Default: 0
let g:deoplete#sources#ternjs#include_keywords = 1

" If completions should be returned when inside a literal. Default: 1
let g:deoplete#sources#ternjs#in_literal = 0


"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]
" If you are using tern_for_vim, you also want to use the same tern command 
" with deoplete-ternjs

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]


"" -->  vinegar.vim
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'


"" --> vim-gutentags
let g:gutentags_cache_dir = stdpath('data'). '/site/tags_cache'



"" --> Alchemist.vim
let g:alchemist#elixir_erlang_src = "/usr/local/share/src"
let g:alchemist_tag_disable = 1
