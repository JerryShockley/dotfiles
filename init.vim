"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Jerry Shockley
"
" This configuration file is optimized for use with Neovim
" in the terminal. There will be significant problems if
" attempting to use this configuration with Vim. 
" This file is broken up into a total of 
" four files in an effort to make the configuration easier
" to work with. With the remaining three being sourced from 
" this file (init.vim). The other three files are:
"
"       - plugins.vim
"       - commands.vim
"       - key_mappings.vim
"
" All four files must be present together in the 
" $XDG_CONFIG_HOME/nvim directory for the source 
" command to work properly for the other three.
"
" This file contains all settings not included in the other
" three files. The other three files contain the following:
"
" plugins.vim --
"       Contains code to create the plugin directory and 
"       initialize the plugins, the list of plugins used,
"       and all plugin specific configurations including 
"       plugin specific key mappings, commands, and 
"       functions.
" commands.vim --
"       Contains all commands and functions except those
"       specific to a plugin.
" key_mappings.vim --
"       Contains all key_mappings except those specific 
"       to a plugin.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Options 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ensure XDG Base Directory Spec environment variables exist.
" These are used by default in the guntime path and by
" defining them here in init.vim using the default path shown
" below ensures this configuration file works even if the 
" user hasn't set the environment variables.
if empty($XDG_CONFIG_HOME)
    let $XDG_CONFIG_HOME = expand($HOME) . '/.config' 
endif
if empty($XDG_DATA_HOME)
    let $XDG_DATA_HOME = expand($HOME) . '/.local/share'
endif

" Set plugged directory location
let plugged_dir = stdpath('data') . '/site/plugged'
" Set after/plugin directory location
let afterplugin_dir = stdpath('config') . '/after/plugin'

" Ensure the plugged and $XDG_DATA_HOME directories exist.
if !isdirectory(plugged_dir)
    call mkdir(plugged_dir, 'p', 0766)
endif

" Ensure the afterplugin_dir directory exist.
if !isdirectory(afterplugin_dir)
    call mkdir(afterplugin_dir, 'p', 0766)
endif

" Append after/plugin dir to rtp to ensure
" it is the last directory loaded.
exec 'set rtp+=' . afterplugin_dir

" Set $MYVIMRC environment variable if not already set.
if empty($MYVIMRC)
    let $MYVIMRC = init_file
endif

" Turn on auto filetype detection for setting correct soft-tab sizes
" and indent sizes. Do this prior to loading commands file, so
" any customizations in that file will override the default.
syntax enable
filetype plugin indent on
filetype indent on

" Create variables for all configuration files
let init_file = stdpath('config') . '/init.vim'
let commands_file = stdpath('config') . '/commands.vim'
let plugins_file = stdpath('config') . '/plugins.vim'
let key_mappings_file = stdpath('config') . '/key_mappings.vim'

"Source all configuration files.
execute 'source ' . commands_file
execute 'source ' . plugins_file
execute 'source ' . key_mappings_file

" Use system clipboard
set clipboard=unnamed
" Sets how many lines of history VIM has to remember
set history=800
" Set path wildcards enable searching the dir subtree when finding files
set path+=**
" Configure backspace so it acts as it should act
set backspace=indent,eol,start
" Enable auto indentation
set autoindent
" Num spaces for tab in file
set tabstop=2
" Num spaces for step in autoindent
set shiftwidth=2
" Num spaces for tab when editing
set softtabstop=2
" Set to auto read when a file is changed from the outside
set autoread
" Set height of Ex cmd line to 2 for long commands.
set cmdheight=2
" How many milliseconds after typing before swapfile is 
" written. Used by LSP servers to determine frequency of
" buffer evaluation.
set updatetime=400
" Hide our abandoned buffers vs deleting them. Used by LSPs
set hidden
" always show signcolumns. Used by LSPs. 
set signcolumn=yes
" Set short message options to use short messages
set shortmess=aFc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent guide
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setCoplors = 1

" Let the colors ring out!
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" Set # lines from pane edge to the cursor - when moving vertically using j/k
set scrolloff=8
" The minimal number of screen columns to keep to the left and to the
" right of the cursor.
set sidescrolloff=5
" The minimal number of columns to scroll horizontally.
" set sidescroll=1
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" Show incomplete commands
set showcmd
" Show line numbers
set relativenumber
set number
" Set number column size
set numberwidth=6
"Always show current position
set ruler
" Height of the command bar
set cmdheight=2
" :how matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set matchtime=5
" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
" Turn on the WiLd menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has('win16') || has('win32')
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
" A buffer becomes hidden when it is abandoned
set hidden

" This causes the left and right arrow keys, as well as h and l, to wrap 
" when used at beginning or end of lines. (  < > are the cursor keys used
" in normal and visual mode, and [ ] are the cursor keys in insert mode).
set whichwrap+=<,>,b,s,[,]

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
set timeoutlen=300

" Add a bit extra margin to the left
set foldcolumn=2
" Set python paths 
let g:python_host_prog = '/Users/jerrys/.asdf/shims/python2'
let g:python3_host_prog = '/Users/jerrys/.asdf/shims/python3'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in Git, git etc anyway...
set nobackup
set nowritebackup
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Linebreak on 100 characters
set linebreak
set textwidth=80
"Wrap lines
set wrap 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen
  set showtablline=2
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Display 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use True Colors
set termguicolors
" Colorscheme
" set background=dark
" Don't try and set colorscheme before the plugin is installed.
if match(&runtimepath, 'oceanic-next') != -1
    colorscheme OceanicNext
endif

" TMux: Automatically Change cursor shape to indicate which mode we're in.
" let &t_SI = '\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\' let &t_SR = '\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\'
" let &t_EI = '\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\'

" Set status line display
" set statusline=%F%m%r%h%w\ \ [%Y]\ [%l,%v]\ [%p%%]\ [B=%n]\ %{strftime('%y-%m-%d')}\ %{strftime('%H:%M:%S')} 

