" This file is sourced by init.vim. It contains all
" of the non-plugin related key mappings.

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Replace characterwise repeat character ',' with '/'
nnoremap \ ,

" Fast saving
nnoremap <leader>w :w!<cr>

" Exit insert mode using jk 
inoremap jk <Esc> 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map keyboard Page-up and Page-down keys to vim commands
nnoremap <silent> <PageUp> 1000<C-U>
nnoremap <silent> <PageDown> 1000<C-D>
inoremap <silent> <PageUp> <C-O>1000<C-U>
inoremap <silent> <PageDown> <C-O>1000<C-D>


" Quicker window movement without the C-w
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


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

"Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>
" Unmaps <CR> o<Esc> when in command and quickfix windows
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Use tab to jump between blocks, because it's easier
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
" Toggle paste mode on and off
nnoremap <leader>pp :setlocal paste!<cr>


" run test runner
nnoremap <leader>t :call RunTestFile()<cr>
nnoremap <leader>T :call RunNearestTest()<cr>



