" Plug
" ----

call plug#begin('~/.vim/plugged')

" functionality
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-unimpaired'
Plug 'embear/vim-localvimrc'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'

" language server protocol
Plug 'w0rp/ale', {'tag': 'v2.6.0'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'stephenway/postcss.vim'

" themes
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'vim-scripts/molokai'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-vividchalk'
Plug '~/Projects/outer-sunset-colors'

call plug#end()


" Configuration
" -------------

" colorscheme molokai
colorscheme OuterSunset
if has('termguicolors')
  set t_Co=256
  set termguicolors
  " colorscheme OceanicNext
  " colorscheme ayu
  " colorscheme onedark
  " let g:onedark_terminal_italics = 1
  " colorscheme gruvbox
  " let g:gruvbox_contrast_dark = 'hard'
  " colorscheme dracula
endif

set background=dark
if exists('+guifont')
  " set guifont=Operator\ Mono:h16
  " set guifont=Fira\ Code:h16
  set guifont=Space\ Mono:h14
  " set guifont=Monaco:h14
endif
set guioptions-=T               " Remove GUI toolbar
set visualbell                  " Suppress audio/visual error bell
set notimeout                   " No command timeout
set showcmd                     " Show typed command prefixes while waiting for operator

set backspace=indent,eol,start
set expandtab                   " Use soft tabs
set tabstop=2                   " Tab settings
set autoindent
set smarttab                    " Use shiftwidth to tab at line beginning
set shiftwidth=2                " Width of autoindent
autocmd FileType py setlocal shiftwidth=4
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
set number                      " Line numbers
set nowrap                      " No wrapping
set ignorecase                  " Ignore case
set smartcase                   " ... unless uppercase characters are involved
autocmd FileType markdown setlocal spell wrap linebreak breakat&vim

set list                        " Show whitespace
set listchars=tab:▸\ ,trail:¬   " UTF-8 characters for trailing whitespace
set virtualedit=onemore         " Cursor can display one character past line
set showmatch                   " Show matching brackets
set hidden                      " Allow hidden, unsaved buffers
set splitright                  " Add new windows towards the right
set splitbelow                  " ... and bottom
set wildmode=list:longest       " Bash-like tab completion
set scrolloff=3                 " Scroll when the cursor is 3 lines from edge
set cursorline                  " Highlight current line
set laststatus=2                " Always show statusline
set statusline=
set statusline+=\ %t\ \|\ len:\ \%L\ \|\ type:\ %Y\ \|\ ascii:\ \%03.3b\ \|\ hex:\ %2.2B\ \|\ line:\ \%2l\ \|\ col:\ %2c

set incsearch                   " Incremental search
set history=1024                " History size

set autoread                    " No prompt for file changes outside Vim
set noswapfile                  " No swap file
set nobackup                    " No backup file
set nowritebackup

" set autowriteall                " Save when focus is lost
" autocmd FocusLost * silent! wall

" Keybindings
" -----------

let mapleader = ","
let maplocalleader = ";"

" kj - The intuitive way to get out of insert mode
imap kj         <Esc>

" Make Y consistent with D and C
map Y           y$

" Indent/unindent visual mode selection
vmap <tab>      >gv
vmap <S-tab>    <gv

" Search
nmap <leader>s  :%s/
vmap <leader>s  :s/

" Toggle highlight search
map <Leader>hh :set hlsearch!<CR>
imap <Leader>hh <ESC>:set hlsearch!<CR>a

" Toggle syntax highlight
map <Leader>ss :if exists("syntax_on") <Bar>
  \   syntax off <Bar>
  \ else <Bar>
  \   syntax enable <Bar>
  \ endif <CR>
imap <Leader>ss <ESC><Leader>ssi

" Split screen
map <leader>v   :vsp<CR>

" Shell commands
map <C-c> :!

" Move between screens
map <leader>w   ^Ww
map <leader>=   ^W=
map <leader>j   ^Wj
map <leader>k   ^Wk
nmap <C-j>      <C-w>j
nmap <C-k>      <C-w>k
nmap <C-h>      <C-w>h
nmap <C-l>      <C-w>l

" Open .vimrc file in new tab. Think Command + , [Preferences...] but with Shift.
map <D-<>       :tabedit ~/.vimrc<CR>

" Reload .vimrc
map <leader>rv  :source ~/.vimrc<CR>
" Remove highlighting post-search
nmap <leader>y  :nohls<CR>

" Undo/redo - Doesn't MacVim already have this?
map <D-z>       :earlier 1<CR>
map <D-Z>       :later 1<CR>

" Auto-indent whole file
nmap <leader>=  gg=G``
map <silent> <F7> gg=G`` :delmarks z<CR>:echo "Reformatted."<CR>

" Jump to a new line in insert mode
imap <D-CR>     <Esc>o

" Fast scrolling
nnoremap <C-e>  3<C-e>
nnoremap <C-y>  3<C-y>

" File tree browser
map \           :NERDTreeToggle<CR>

" File tree browser showing current file - pipe (shift-backslash)
map \|          :NERDTreeFind<CR>

" Previous/next quickfix file listings (e.g. search results)
map <M-D-Down>  :cn<CR>
map <M-D-Up>    :cp<CR>

" Previous/next buffers
map <M-D-Left>  :bp<CR>
map <M-D-Right> :bn<CR>

" FuzzyFinder and switchback commands
" map <leader>e   :e#<CR>
" map <leader>b   :FufBuffer<CR>
" map <leader>f   <Plug>PeepOpen
" map <leader><C-N> :FufFile **/<CR>

" Command-T
" map <D-e>       :CommandTBuffer<CR>
" map <D-N>       :CommandTFlush<CR>:CommandT<CR>
" imap <D-N>      <Esc>:CommandTFlush<CR>:CommandT<CR>
" nmap <leader>t  :CommandT<CR>

" CtrlP
map <leader>p :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
" let g:ctrlp_custom_ignore = '\v[\/](node_modules)|(\.(git|hg|svn))$'

" ripgrep
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0

" AG
elseif executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0
endif

" Git blame
map <leader>g   :Gblame<CR>

" Comment/uncomment lines
map <leader>/   <plug>NERDCommenterToggle
map <D-/>       <plug>NERDCommenterToggle
imap <D-/>      <Esc><plug>NERDCommenterToggle i

" Copy current file path to system pasteboard
map <silent> <D-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>

" Disable middle mouse button, F1
map <MiddleMouse>   <Nop>
imap <MiddleMouse>  <Nop>
map <F1>            <Nop>
imap <F1>           <Nop>

" Easy access to the shell
map <Leader><Leader> :!

" Change directory to current file
map <Leader>cd :lcd %:p:h<CR>

" Pad comment delimeters with spaces
let NERDSpaceDelims = 1

" Small default width for NERDTree pane
let g:NERDTreeWinSize = 20

" Small default height for CommandT
let g:CommandTMaxHeight=20

" Change working directory if you change root directories
let g:NERDTreeChDirMode=2

" Use paste mode when replacing. (Work in progress.)
" vmap <silent> <C-K> :<C-U>call InPasteMode("<Plug>ReplaceVisual")<CR>
" function! InPasteMode(command)
  " let oldpaste = &l:paste
  " try
    " set paste
    " execute "normal" "gv".a:command
  " finally
    " let &l:paste = oldpaste
  " endtry
" endfunction

" Find current word in command mode
function! AckGrep()
  let command = "ack ".expand("<cword>")
  cexpr system(command)
  cw
endfunction

function! AckVisual()
  normal gv"xy
  let command = "ack ".@x
  cexpr system(command)
  cw
endfunction

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" AckGrep current word
" map <leader>a :call AckGrep()<CR>
" AckVisual current selection
" vmap <leader>a :call AckVisual()<CR>

" ack.vim
map <leader>a :Ack 


" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"


" Whitespace & highlighting & language-specific config
" ----------------------------------------------------

" Strip trailing whitespace for code files on save
" C family
autocmd BufWritePre *.m,*.h,*.c,*.mm,*.cpp,*.hpp :%s/\s\+$//e

" Ruby, Rails
autocmd BufWritePre *.rb,*.yml,*.js,*.json,*.css,*.less,*.sass,*.html,*.xml,*.erb,*.haml,*.feature :%s/\s\+$//e
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.god set filetype=ruby
au BufRead,BufNewFile Gemfile* set filetype=ruby
au BufRead,BufNewFile Guardfile* set filetype=ruby
au BufRead,BufNewFile Vagrantfile set filetype=ruby
au BufRead,BufNewFile soloistrc set filetype=ruby

" Jinja
au BufRead,BufNewFile *.html.jinja set filetype=jinja

" Java, PHP
autocmd BufWritePre *.java,*.php :%s/\s\+$//e

" Highlight JSON files as javascript
" autocmd BufRead,BufNewFile *.json set filetype=javascript

" Highlight Jasmine fixture files as HTML
autocmd BufRead,BufNewFile *.jasmine_fixture set filetype=html

" Consider question/exclamation marks to be part of a Vim word.
autocmd FileType ruby set iskeyword=@,48-57,_,?,!,192-255
autocmd FileType scss set iskeyword=@,48-57,_,-,?,!,192-255

" Insert ' => '
autocmd FileType ruby imap  <Space>=><Space>


" syntax vars
" -----------

" markdown
let g:vim_markdown_folding_disabled = 1

" this doesn't work yet
let g:javascript_plugin_flow = 0

" python
let g:python_highlight_all = 1



" Syntastic
" ---------

" set statusline+=\ \|\ %#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_jsx_checkers = ['eslint']
" let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_python_flake8_args='--max-line-length=120 --ignore=E402,E731,E711'


" airline
" ---
let g:airline#extensions#ale#enabled = 1


" ale
" ---
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fix_on_save = 0
let g:ale_fixers = {
\  'javascript': ['prettier', 'eslint'],
\  'javascriptreact': ['prettier', 'eslint'],
\  'typescript': ['prettier'],
\  'typescriptreact': ['prettier'],
\  'json': ['prettier'],
\  'css': ['prettier'],
\  'scss': ['prettier'],
\  'markdown': ['prettier'],
\  'python': ['autopep8'],
\  'go': ['gofmt'],
\}

highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)

" let g:ale_sign_error = 'X' " could use emoji
" let g:ale_sign_warning = '?' " could use emoji
" let g:ale_statusline_format = ['X %d', '? %d', '']

" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'

" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>an :ALENext -error -wrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

" Go to definition
nnoremap <leader>d :ALEGoToDefinition<cr>

map <leader>f :ALEFix<CR>


" CoC
" ---

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" .vimrc.local Options
" --------------------
"
" No GUI tab bar
" set guioptions-=e

" No scrollbars
" set guioptions-=rL

" 256 colors
" set t_Co=256

" Change background color in insert mode
" let g:insert_mode_background_color = "#18434E"

" Machine-local vim settings - keep this at the end
silent! source ~/.vimrc.local
