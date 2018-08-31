" vim: foldmethod=marker
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Jerry Shockley
 "
" Version: 
"       0.9 - 2017-06-19
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Options  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set not vi compatible as this limits are features
set nocompatible

" Sets how many lines of history VIM has to remember
set history=500
    :
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set path wildcards enable searching the dir subtree when finding files
set path+=**

" Expand tabs using spaces vs tabs when indenting using '>>'
set expandtab 

" Set to auto read when a file is changed from the outside
set autoread

" Automatically :write before running command

" Show incomplete commands
set showcmd

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Replace characterwise repeat character ',' with '/'
noremap \ ,

" Fast saving
nmap <leader>w :w!<cr>

" Increase size of preview window for Fugitive.
" Note the fugitive plugin must be reloaded for
" this option.
set previewheight=25   

" :Sw sudo saves the file 
" (useful for handling the permission-denied error)
command Sw w !sudo tee expand('%:p') > /dev/null



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" Set # lines from pane edge to the cursor - when moving vertically using j/k
set scrolloff=8
" The minimal number of screen columns to keep to the left and to the
" right of the cursor.
set sidescrolloff=15
" The minimal number of columns to scroll horizontally.
set sidescroll=1

" Quicker window movement without the C-w
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Make it easier to close and open windows
nnoremap <C-c> <C-w>c

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Show line numbers
set rnu
set nu

" Set number column size
set numberwidth=6

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Creates a toggle command toggling between relative and absolute line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" Auto switch to absolute line nums when entering insert mode
autocmd InsertEnter * set norelativenumber

" Auto switch to absolute line nums when exiting insert mode
autocmd InsertLeave * set relativenumber

" :how matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=5


" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
set foldcolumn=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Auto Funtions/Actions  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto reload .vimrc on change
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC

augroup END " }

" Install vim-plug if it isn't already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in Git, git et.c anyway...
set nobackup
set nowb
set noswapfile

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile Appraisals set filetype=ruby
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
" set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related  {{{1
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings  {{{1
" """""""""""""""""""""""""""
if has ('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-v><Esc> <Esc>
endif

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

nmap bs :Buffers<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
map <leader>lcd :lcd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`]z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

"Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>
"Below is to fix issues with the ABOVE mappings in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %



" Stop highlight after searching
nnoremap <silent> <leader>, :noh<cr>

" Toggle relativenumbers
nnoremap <C-n> call NumberToggle()<cr>

" Map keyboard Page-up and Page-down keys to vim commands
map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>


" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Set paths to Python 2 & 3. These may need to be updated
" as new versions are release.
let g:python_host_prog = $HOME . '/.asdf/installs/python/2.7.15/bin/python'
let g:python3_host_prog = $HOME . '/.asdf/installs/python/3.7.0/bin/python'

" :W and :Save will escape a file name and write it
" command! -bang -nargs=* W :call W(<q-bang>, <q-args>) 
" command! -bang -nargs=* Save :call Save(<q-bang>, <q-args>) 

" function! W(bang, filename) 
"     :exe "w".a:bang." ". fnameescape(a:filename) 
" endfu 

" function! Save(bang, filename) 
"     :exe "save".a:bang." ". fnameescape(a:filename) 
" endfu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Testing Functions  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" run test runner
map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>

function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !clear
  if match(a:filename, '\.feature$') != -1
    exec ":!bundle exec cucumber " . a:filename
  elseif match(a:filename, '_test\.rb$') != -1
    if filereadable("bin/testrb")
      exec ":!bin/testrb " . a:filename
    else
      exec ":!ruby -Itest " . a:filename
    end
  else
    if filereadable("Gemfile")
      exec ":!bundle exec rspec --color " . a:filename
    else
      exec ":!rspec --color " . a:filename
    end
  end
endfunction

function! SetTestFile()
  " set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction


function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number . " -b")
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Display   {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set font according to system
if has("mac") || has("macunix")
    set gfn=Hack:h15,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=Hack:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

syntax enable


if !has('gui_running')
  set t_Co=256
endif


if ('nvim')
    set termguicolors
    set cursorline
else
    " We're using Vim
    
    " iTerm2: Automatically Change cursor shape to indicate which mode we're in.
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"

    " Turns on an underline for the line containing the cursor
    " set cursorline
    hi CursorLine term=bold cterm=bold guibg=Grey40 ctermbg=Black

    if('gui_running')
            set t_Co=256
    else

    endif
endif


" let g:solarized_termcolors=256

" Colorscheme
set background=dark
" colorscheme peaksea
colorscheme solarized8_dark_flat

" TMux: Automatically Change cursor shape to indicate which mode we're in.
" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Set line number color to grey
" hi LineNr guifg=#666666 

" Set fold column color to grey
" hi FoldColumn guifg=#666666 guibg=#111111 ctermfg=#e4e4e4 ctermbg=#8a8a8a 

""""""""""""""""""""""""""""""
" => Status line  {{{2
""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins   {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" -- Tech Integration Plugs

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" -- Display/Misc Plugs
"  Make terminal vim and tmux work better together.
Plug 'tmux-plugins/vim-tmux-focus-events'

" Enables live previews of markdown files
Plug 'JamshedVesuna/vim-markdown-preview'

" Color scheme
Plug 'NLKNguyen/papercolor-theme'
" Plug 'dahu/vimLint'

" -- Search Plugs

" Vim utility scripts

" Status line display.  Requires vim-fugitive.
Plug 'itchyny/lightline.vim'

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

" -- Navigation Plugs
" Quickly and easily switch between buffers.
Plug 'jlanzarotta/bufexplorer'
" Command line fuzzy finder
Plug 'junegunn/fzf'
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
Plug 'tpope/vim-dispatch'
" Multilanguage vim test runner
Plug 'janko-m/vim-test'
" A collection of Programming Language Packs for most languagesk40
Plug 'sheerun/vim-polyglot'
" Asynchronous linting and make framework for Neovim/Vim
Plug 'neomake/neomake' 
" Dark powered asynchronous completion framework for neovim/Vim8
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
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

" This is a Vim plugin that provides Tern-based JavaScript editing support.
Plug 'ternjs/tern_for_vim'
" deoplete.nvim source for javascript
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" -- Color Schemes
Plug 'lifepillar/vim-solarized8'


call plug#end()

" Set run time path
set rtp+=/usr/local/opt/fzf,$VIMRUNTIME



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Configs   {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" -->  vim-grepper

let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg'] 
let g:grepper.jump = 1

" let g:grepper.

" Search for current word
" nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
"
" nmap gs <plug>(GrepperOperator)
" xmap gs <plug>(GrepperOperator)

function! SetupCommandAlias(input, output)
    exec 'cabbrev <expr> '.a:input
         \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
         \ .'?("'.a:output.'") : ("'.a:input.'"))'
endfunction

call SetupCommandAlias("grep", "GrepperGrep")
call SetupCommandAlias("git", "GrepperGit")
call SetupCommandAlias("rg", "GrepperRg")


"" --> vim-clevertab
inoremap <silent><tab> <c-r>=CleverTab#Complete('start')<cr>
                      \<c-r>=CleverTab#Complete('tab')<cr>
                      \<c-r>=CleverTab#Complete('neosnippet')<cr>
                      \<c-r>=CleverTab#Complete('keyword')<cr>
                      \<c-r>=CleverTab#Complete('omni')<cr>
                      \<c-r>=CleverTab#Complete('stop')<cr>
inoremap <silent><s-tab> <c-r>=CleverTab#Complete('prev')<cr>

"" --> deoplete
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"" --> vim-markdown-preview
let vim_markdown_preview=2
" let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_hotkey='<F9>'
let vim_markdown_preview_github=1



"" --> vim-test

let test#strategy = 'neomake'

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<C-R>

"" --> NeoMake
" Run make when we save a buffer
call neomake#configure#automake('rw')

let g:neomake_elixir_enabled_makers = ['mix']
let g:neomake_open_list = 2
let g:quickfixsigns_protect_sign_rx = '^neomake_'
" let g:neomake_verbose = 3
" let g:neomake_logfile = '/users/jerrys/src/elixir/prototypes/issues/nmake.log'

"" --> Ale Asynchronous Lint Engine"
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" " ALE linting events
" set updatetime=1000
" let g:ale_lint_on_text_changed = 0
" autocmd CursorHold * call ale#Lint()
" autocmd CursorHoldI * call ale#Lint()
" autocmd InsertEnter * call ale#Lint()
" autocmd InsertLeave * call ale#Lint()

"     " Move between linting errors
" nnoremap ]r :ALENextWrap<CR>
" nnoremap [r :ALEPreviousWrap<CR>

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
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

"" -->  vinegar.vim
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'


"" --> vim-gutentags
let g:gutentags_cache_dir = '~/.tags_cache'

"" --> Alchemist.vim
let g:alchemist#elixir_erlang_src = "/usr/local/share/src"
let g:alchemist_tag_disable = 1



