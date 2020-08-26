" This file is sourced by init.vim. It contains the
" list of plugins along with all plugin related functions,
" Commands, and key mappings.

" Install vim-plug if it isn't already installed
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
    let plugurl = 'https://raw.githubusercontent.com/' .
        \'junegunn/vim-plug/master/plug.vim'
    let plugdir = stdpath('data') . '/site/autoload/plug.vim'  
   silent execute '!curl -fLo '. plugdir .' --create-dirs '. plugurl  
   augroup pluginstall
     autocmd!
     autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
   augroup end
endif


call plug#begin(plugged_dir)


let plug_shallow = 0
" -- Tech Integration Plugs

" -- Display/Misc Plugs

"  Make terminal vim and tmux work better together.
" Plug 'tmux-plugins/vim-tmux-focus-events'
" A Vim plugin for Vim plugins
Plug 'tpope/vim-scriptease'
" Enables live previews of markdown files
Plug 'shime/vim-livedown'

" -- Search Plugs
" easily search for, substitute, and abbreviate multiple variants of a word 
Plug 'tpope/vim-abolish'

" -- Vim utility scripts

" Status line display.  Requires vim-fugitive.
Plug 'rbong/vim-crystalline'

" -- Editing Plugs

" Generic Snippet Library
Plug 'honza/vim-snippets'
" React snippets
Plug 'mlaursen/vim-react-snippets'
" Comments stuff out.
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
" This conficts with coc.nvim <CR> mapping!
" Plug 'tpope/vim-endwise'
" Shows a git diff in the 'gutter'
Plug 'airblade/vim-gitgutter'
" Manage sessions
Plug 'tpope/vim-obsession'
" Manages many git functions from within vim
Plug 'tpope/vim-fugitive'
" UNIX helpers
Plug 'tpope/vim-eunuch'
" HTML editing shortcuts
Plug 'mattn/emmet-vim'

"-- Navigation Plugs

"  Fuzzy searchs many prepared sources (e.g. file, buffers,
"  etc)j. As a Neovim plugin it has
"  access to more sources than FZF, but may be a
"  bit slower.
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' } 
" Add Denite sources
" Save yank history and create source
Plug 'Shougo/neoyank.vim'
" git source
Plug 'neoclide/denite-git'
" Custom denite sorter
Plug 'rafi/vim-denite-z'
" Quickly and easily switch between buffers.
Plug 'jlanzarotta/bufexplorer'
" Use your favorite grep tool to start an asynchronous search
Plug 'mhinz/vim-grepper'
" Add some sugar to netrw
Plug 'tpope/vim-vinegar'

" -- General Programming Language Support
" Intellisense engine. Requires Nodejs.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" A vim plugin for syntax highlighting Ansible's common filetypes
Plug 'pearofducks/ansible-vim', {'do': './Ultisnips/generate.sh'}
" Check syntax in Vim asynchronously and fix files, with Language 
" Server Protocol (LSP) support
Plug 'dense-analysis/ale'
" Dark powered asynchronous completion framework for neovim/Vim8
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } 
" neo-snippet plugin contains neocomplcache snippets source
Plug 'Shougo/neosnippet.vim'
" The standard snippets repository for neosnippet
Plug 'Shougo/neosnippet-snippets'
" A code formatter plugin
Plug 'sbdchd/neoformat'
" Run a command and show it's results quickly
Plug 'thinca/vim-quickrun'

" -- Elixir/Phoenix Language Support

" uses alchemist-server to give inside information 
" about your elixir project in vim.
" Plug 'slashmili/alchemist.vim'
" Elixir web development framework
" Plug 'c-brenn/phoenix.vim'
" Project config using projections
" Plug 'tpope/vim-projectionist'

" -- Javascript Language Support

" Typescript syntax files for Vim
Plug 'HerringtonDarkholme/yats.vim'
" [Vim script] JSX and TSX syntax pretty highlighting for 
Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Personal Wiki
Plug 'vimwiki/vimwiki'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
    
" -- Color Schemes
Plug 'mhartington/oceanic-next'
" Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'

call plug#end()



" ===============================================

"    PLUGIN Configs

" ===============================================

"  --> vim-chrystalline
function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f%h%w%m%r '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{LinterStatus()}'
  endif

  if a:current
    let l:s .= ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' [%{&ft}] %l/%L %c%V %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! TabLine()
  let l:vimlabel = 'Jerry Shockley'
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . '%=%{ObsessionStatus()}'
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'papercolor'
let g:crystalline_enable_sep = 1
set showtabline=2
set laststatus=2


" --> vim-fugitive
nnoremap <leader>gs :G<CR>
nnoremap <leader>gc :G commit<CR>
nnoremap <leader>gp :Git_push<CR>
nnoremap <leader>gl :G pull<CR>

" augroup myfugitive
"   autocmd!  
" Deletes buffers when you leave while browsing git
" objects.
  " autocmd BufReadPost fugitive://* set bufhidden=delete

" Presing c will jump to the commit object for the 
" current tree when the current buffer contains a tree or
" blob.
    " autocmd User fugitive 
    "   \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    "   \   nnoremap <buffer> .. :edit %:h<CR> |
    "   \ endif
" augroup END


" --> Emmet

let g:user_emmet_leader_key=','
let g:jsx_ext_required = 0

let g:user_emmet_settings = {
  \  'javascriptreact' : {
    \      'extends' : 'jsx',
    \  },
  \ }



" -->  vim-grepper

let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg'] 
let g:grepper.jump = 1
" Search for current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
" Search for the current selection
nnoremap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

call SetupCommandAlias('grep', 'GrepperGrep')
call SetupCommandAlias('git', 'GrepperGit')
call SetupCommandAlias('rg', 'GrepperRg')

" -->  Denite

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="

" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nnoremap <leader>d :Denite buffer file/rec<CR>
nnoremap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
" nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file ina new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
" vint: -ProhibitAutocmdWithNoGroup
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <C-y>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
" <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
" vint: -ProhibitAutocmdWithNoGroup
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction 

call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of 'grep'
call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
" call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': '> ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlightmatched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

"  --> ALE
nnoremap <silent> <leader>j  :ALENextWrap<CR>
nnoremap <silent> <leader>k  :ALEPreviousWrap<CR>

let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 1
let g:ale_open_list = 1
" highlight ALEErrorSign ctermbg=NONE ctermfg=red
" highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
" let g:ale_linters_ignore = {
" \ 'vim': ['vim_language_server']    
" \ }

let g:ale_linters = { 
\   'ansible': ['ansible-lint'],
\   'yaml': ['yamllint'],
\   'javascriptreact': ['stylelint', 'eslint'],
\   }
" let g:ale_linter_aliases = {
"  \   'javascriptreact': 'css',
"  \   'ansible': 'yaml'
"  \}

" let g:ale_fixers = {
" \    'javascript': ['prettier'],
" \    'typescript': ['prettier'],
" \    'vue': ['eslint'],
" \    'scss': ['prettier'],
" \    'html': ['prettier']
" \}
let g:ale_fix_on_save = 1

" Calculates and formats linter summary info for statusline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
    \  '%dE  %dW',
    \  all_errors,
    \  all_non_errors
    \)
endfunction


" --> Obsession

nnoremap <silent> <leader>o :Obsession<CR>
nnoremap <silent> <leader>ok :Obsession!<CR>


" --> vim-livedown
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 1

" should the browser window pop-up upon previewing
let g:livedown_open = 1

" the port on which Livedown server will run
let g:livedown_port = 1337

" the browser to use, can also be firefox, chrome or other, depending on your executable
let g:livedown_browser = 'chrome'


" -->  vinegar.vim
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'


" --> coc.nvim
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \ 'coc-xml',
  \ 'coc-yank'
  \ ]

" Use tab for trigger completion with characters ahead and navigate
" to next complete item.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" This mapping is subsumed by coc-snippets mapping in the coc-snippets section.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? '\<C-n>' :
"       \ <SID>check_back_space() ? '\<TAB>' :
"       \ coc#refresh()


" Use Shift-<TAB> for trigger completion
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<Tab>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <CR> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr><CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)


" Remap keys for gotos
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nnoremap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nnoremap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
" Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>c  <Plug>(coc-codeaction-selected)
nnoremap <leader>c  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nnoremap <leader>cc  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nnoremap <leader>cf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document 
" symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, 
" like: coc-tsserver, coc-python
nnoremap <silent> <space>d <Plug>(coc-range-select)
xmap <silent> <space>d <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<CR>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<CR>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<CR>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"  --> Coc-Snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

let g:coc_snippet_next = '<tab>'


" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
