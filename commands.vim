"This file is sourced by init.vim. It contains all
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
function! DeleteTrailingWS()
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

augroup fix_normal_newline_map
    autocmd!
    " Unmaps <CR> o<Esc> when in command and quickfix windows
    autocmd CmdwinEnter * nnoremap <CR> <CR>
    autocmd BufReadPost quickfix nnoremap <CR> <CR>
augroup END

augroup buff_rw
    autocmd!
    " Auto reload init.vim on change
     autocmd BufWritePost init.vim,commands.vim,plugins.vim,key_mappings.vim nested source $MYVIMRC | echom "Sourcing " . $MYVIMRC

    " Remove trailing white space before saving buffer
    autocmd BufWrite *.py,*.ts,*.tsx,*.js,*.jsx,*.yml call DeleteTrailingWS()

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END 

augroup misc
     autocmd!
     " Override tab and shift settings for .vim files. 8 is too big!
     autocmd Filetype vim setlocal shiftwidth=2 softtabstop=2 expandtab
     " Switch to alternate tab
    autocmd TabLeave * let g:lasttab = tabpagenr()
    autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab    
    autocmd FileType javascript,typescript,jsx,tsx setlocal shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType css setlocal shiftwidth=2 softtabstop=2 expandtab    
augroup END

