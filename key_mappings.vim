"This file is sourced by init.vim. It contains all
" of the non-plugin related key mappings.

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file

let mapleader = ","
let g:mapleader = ","

" Replace characterwise repeat character ',' with '/'
nnoremap \ ,

" Managing Configuration
nnoremap <silent> <leader>as :exe 'source ' . $MYVIMRC
                              \ \| echo 'Sourcing ' . $MYVIMRC <CR>
nnoremap <silent> <leader>ai :exe 'e ' . init_file . '<CR>'
nnoremap <silent> <leader>am :exe 'e ' . key_mappings_file . '<CR>'
nnoremap <silent> <leader>ac :exe 'e ' . commands_file  . '<CR>'
nnoremap <silent> <leader>ap :exe 'e ' . plugins_file  . '<CR>'

" Fast saving
nnoremap <leader>w :w!<cr>

" Optional key sequence to enter normal mode from insert mode.
inoremap jj <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add shortcut to switch from Terminal mode to Normal mode
tnoremap jj <C-\><C-n>
" Add a mapping to insert a literal <Esc> character in Terminal Mode
tnoremap <C-v><Esc> <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" noremap keyboard Page-up and Page-down keys to vim commands
nnoremap <silent> <PageUp> 1000<C-U>
nnoremap <silent> <PageDown> 1000<C-D>
inoremap <silent> <PageUp> <C-O>1000<C-U>
inoremap <silent> <PageDown> <C-O>1000<C-D>


" Quicker window movement without the C-w
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Open a split with current file
nnoremap <silent> vv <C-w>v<C-w>l
nnoremap <silent> vh <C-w>s<C-w>j
" Close adjacent window
nnoremap <silent> <leader>xk <C-W><C-K>:q!<cr>
nnoremap <silent> <leader>xj <C-W><C-J>:q!<cr>
nnoremap <silent> <leader>xh <C-W><C-H>:q!<cr>
nnoremap <silent> <leader>xl <C-W><C-L>:q!<cr>

"make resizing a breeze
if bufwinnr(1)
  noremap _ <C-W>-5
  noremap + <C-W>+5
  noremap = <C-W>>5
  noremap <leader>- <C-W><5
endif


""""""""""""""""""""""""""""""
" => Visual mode related 
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn off search results highlighting 
nnoremap <silent> <leader>, :noh<cr>
" Toggle relativenumbers
nnoremap <C-n> call NumberToggle()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
nnoremap <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" run test runner
" nnoremap <leader>t :call RunTestFile()<cr>
" nnoremap <leader>T :call RunNearestTest()<cr>



nnoremap <silent> <leader>ai :e ~/src/dotfiles/init.vim<CR>
" nnoremap <silent> <leader>ap :e 
" nnoremap <silent> <leader>as :source $MYVIMRC

" Fast saving
nnoremap <leader>w :w!<cr>

" Optional key sequence to enter normal mode from insert mode.
inoremap jj <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add shortcut to switch from Terminal mode to Normal mode
tnoremap jj <C-\><C-n>
" Add a mapping to insert a literal <Esc> character in Terminal Mode
tnoremap <C-v><Esc> <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" noremap keyboard Page-up and Page-down keys to vim commands
nnoremap <silent> <PageUp> 1000<C-U>
nnoremap <silent> <PageDown> 1000<C-D>
inoremap <silent> <PageUp> <C-O>1000<C-U>
inoremap <silent> <PageDown> <C-O>1000<C-D>


" Quicker window movement without the C-w
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Open a split with current file
nnoremap <silent> vv <C-w>v<C-w>l
nnoremap <silent> vh <C-w>s<C-w>j
" Close adjacent window
nnoremap <silent> <leader>xk <C-W><C-K>:q!<cr>
nnoremap <silent> <leader>xj <C-W><C-J>:q!<cr>
nnoremap <silent> <leader>xh <C-W><C-H>:q!<cr>
nnoremap <silent> <leader>xl <C-W><C-L>:q!<cr>

"make resizing a breeze
if bufwinnr(1)
  noremap _ <C-W>-5
  noremap + <C-W>+5
  noremap = <C-W>>5
  noremap <leader>- <C-W><5
endif


""""""""""""""""""""""""""""""
" => Visual mode related 
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn off search results highlighting 
nnoremap <silent> <leader>, :noh<cr>
" Toggle relativenumbers
nnoremap <C-n> call NumberToggle()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
nnoremap <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" run test runner
" nnoremap <leader>t :call RunTestFile()<cr>
" nnoremap <leader>T :call RunNearestTest()<cr>



