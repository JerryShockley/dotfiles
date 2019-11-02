"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" key_mappings --
"       Contains all key_mappings except those specific 
"       to a plugin.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Options 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ensure XDG Base Directory Spec environment variables exist.
" These are used by default in the runtime path and by
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
let g:plugged_dir = stdpath('data') . '/site/plugged'

" Ensure the plugged and $XDG_DATA_HOME directories exist.
if !isdirectory(g:plugged_dir)
    call mkdir(g:plugged_dir, "p", 0700)
endif

" Set not vi compatible as this limits our features
set nocompatible

execute 'source ' . stdpath('config') . '/commands.vim'
execute 'source ' . stdpath('config') . '/plugins.vim'
execute 'source ' . stdpath('config') . '/key_mappings.vim'


filetype plugin indent on
syntax enable
 
" Sets how many lines of history VIM has to remember
set history=800
" Set path wildcards enable searching the dir subtree when finding files
set path+=**
" Expand tabs using spaces vs tabs when indenting using '>>'
set expandtab 
" Set to auto read when a file is changed from the outside
set autoread
" Increase size of preview window for Fugitive.
" Note the fugitive plugin must be reloaded for
" this option.
set previewheight=25   

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Let the colors ring out!
let $NVIM_GUI_ENABLE_TRUE_COLOR=1
" Set # lines from pane edge to the cursor - when moving vertically using j/k
set scrolloff=8
" The minimal number of screen columns to keep to the left and to the
" right of the cursor.
set sidescrolloff=15
" The minimal number of columns to scroll horizontally.
set sidescroll=1
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" Show incomplete commands
set showcmd
" Show line numbers
set rnu
set nu
" Set number column size
set numberwidth=6
"Always show current position
set ruler
" Height of the command bar
set cmdheight=2
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
set backspace=indent,start
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
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in Git, git etc anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Linebreak on 100 characters
set lbr
set tw=100

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen
  set stal=2
catch
endtry

" Set paths to Python 2 & 3. These need to be updated
" as new versions are released. Updating python versions
" also requires installing the https://github.com/neovim/pynvim python
" package using:
" pip2 install pynvim
" pip3 install pynvim
let g:python_host_prog = $HOME . '/.asdf/installs/python/2.7.16/bin/python'
let g:python3_host_prog = $HOME . '/.asdf/installs/python/3.7.3/bin/python'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Display 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use True Colors
set termguicolors
" Colorscheme
set background=dark
" Don't try and set colorscheme before the plugin is installed.
if match(&rtp, 'gruvbox') != -1
    colorscheme gruvbox
endif

" TMux: Automatically Change cursor shape to indicate which mode we're in.
" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Set status line display
" set statusline=%F%m%r%h%w\ \ [%Y]\ [%l,%v]\ [%p%%]\ [B=%n]\ %{strftime('%y-%m-%d')}\ %{strftime('%H:%M:%S')} 

