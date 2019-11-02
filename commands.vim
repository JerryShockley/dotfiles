" This file is sourced by init.vim. It conatains all
" the non-plugin related functions and commands.

"====================================================
" ***  FUNCTIONS
"====================================================

" Toggle function toggling between relative and absolute line numbers
" Used by autocommand
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
 
"Delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" Returns true if paste mode is enabled. Useful for status line
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer.
" Used by command Bclose
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


" Creates a command alias/abbreviation that only expands when
" it immediately follows the : of an ex command. This
" prevents an expansion when used later in the line, 
" at search prompt or in the middle of a
" :substitute command.
function! SetupCommandAlias(input, output)
    exec 'cabbrev <expr> '.a:input
         \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
         \ .'?("'.a:output.'") : ("'.a:input.'"))'
endfunction


"====================================================
" ***  COMMANDS
"====================================================

" :Sw saves the file using sudo
" (useful for handling the permission-denied error)
command! Sw :w !sudo tee expand('%:p') > /dev/null

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

"====================================================
" ***  AUTOCOMMANDS
"====================================================

" Remove trailing white space before saving buffer
autocmd BufWrite *.py,*.js,*.jsx,*.yml :call DeleteTrailingWS()

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Return to last edit position when opening files (You want this!)
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Auto reload init.vim on change
augroup reload_vimrc " {
    autocmd!
    execute 'autocmd BufWritePost' stdpath('config') . '/*.vim source $MYVIMRC'
augroup END " }

" Switch to alternate tab
au TabLeave * let g:lasttab = tabpagenr()


