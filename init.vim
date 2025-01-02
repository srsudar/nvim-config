" Load Packer plugins
lua require('plugins')
lua require('kickstart')

"
" Behavior Configuration
" ----------------------


"
" Mappings
" --------

" Reload .vimrc
" map <leader>rv  :source ~/.config/nvim/init.vim<CR>

" Change directory to current file
map <Leader>cd :lcd %:p:h<CR>

" leap behavior. Prepend with s basically
nnoremap <leader>f <Plug>(leap-forward)
nnoremap <leader>F <Plug>(leap-backward)
nnoremap <leader>x <Plug>(leap-forward-till)
nnoremap <leader>X <Plug>(leap-backward-till)

" neoformat for prettier
let g:neoformat_try_node_exe = 1
autocmd BufWritePre *.js Neoformat prettier
autocmd BufWritePre *.ts Neoformat prettier
autocmd BufWritePre *.jsx Neoformat prettier
autocmd BufWritePre *.tsx Neoformat prettier

" run our format-file fn on the current file
nnoremap <Leader>f :silent exec '!npm run format-file ' . expand('%')<CR>


" make ctrl+c work
" set clipboard=unnamed
" set clipboard+=unnamedplus
" vnoremap <C-c>  "+y
" vnoremap <C-c> "*y

" colorscheme molokai
" colorscheme vim
" colorscheme OuterSunset
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

" We need this for rainbow. This lets us use `:RainbowToggle` to turn it on.
let g:rainbow_active = 0

" All the cpp highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" For Yggdrot/intentline, stop messing with json and markdown hiding things
autocmd Filetype json let g:indentLine_setConceal = 0
autocmd Filetype markdown let g:indentLine_setConceal = 0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

let g:markdown_enable_insert_mode_mappings = 0

let g:peekaboo_delay = 1500

let g:ctrlp_switch_buffer = ''

nnoremap <c-p> :FZF<cr>
" Various FZF shortcuts
" eg this opens buffers with \b
nnoremap <Leader>b :Buffers<cr>
nnoremap <leader>F :FZF<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <leader>L :Rg!<cr>
nnoremap <leader>M :Maps<cr>
" nnoremap <leader>r :Rg<cr>
nnoremap <leader>R :Rg!<cr>
nnoremap <leader>h :History<cr>

" Rather than open empty splits, open with the existing file.
nnoremap <c-w>n :split<cr>
nnoremap <c-w>v :vsplit<cr>

" Treat all *.md files as markdown, not just README.md. Otherwise vim by
" default treats *.md files as modula-2: https://github.com/tpope/vim-markdown
augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal spell
  " Open table of contents with <leader>lt
  autocmd Filetype markdown map <buffer> <leader>lt :Toc<CR>
  " highlight bold
  autocmd FileType markdown highlight htmlBold ctermbg=60
  " View markdown in Marked 2 with <leader>lv. This is lo to mirror the view
  " functionality in my LaTeX plugin.
  autocmd FileType markdown map <buffer> <leader>lv :silent! !open -a Marked\ 2 % > /dev/null &<cr>:redraw!<cr>

  " gabrielelana/vim-markdown override textwidth to 0 for some reason, so re-set
  " it here to get back wrapping.
  autocmd Filetype markdown setlocal textwidth=80
augroup END

" Remap mark to gm, allowing easyclip to use m for move
nnoremap gm m

" Set paste by default when pasting from insert and command mode.
imap <c-v> <plug>EasyClipInsertModePaste
cmap <c-v> <plug>EasyClipCommandModePaste

" Use one space instead of two when fixing up after sentences.
set nojoinspaces

" typescript and jsx, based on the peitalin/vim-jsx-typescript readme.
" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" vim latex
" don't complain if we're not using +clientserver
let g:vimtex_echo_ignore_wait = 1
" autocomplete citations with ycm. :h vimtex-complete-youcompleteme
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
      \ 're!\\hyperref\[[^]]*',
      \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\(include(only)?|input){[^}]*',
      \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
      \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
      \ ]
" Open using skim
let g:vimtex_view_general_viewer
      \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
" Put build files in gen
" let g:vimtex_latexmk_build_dir = './generated'

" Don't move the cursor when you join lines with J
:nnoremap <silent> J :let p=getpos('.')<bar>join<bar>call setpos('.', p)<cr>

" Airline
let g:airline_theme='murmur'
" Don't want to require patched font, so change separator.
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" Turn off file type, which is useless. Keep tagbar and virtual env, like
" default
let g:airline_section_x = airline#section#create_right(['tagbar', 'virtualenv'])
" Turn off file type and file encoding
let g:airline_section_y = 0
" Handle whitespace errors with airline
autocmd FileType * unlet! g:airline#extensions#whitespace#checks
autocmd FileType markdown let g:airline#extensions#whitespace#checks = [ 'indent' ]
" Enable Tabline
let g:airline#extensions#tabline#enabled = 1
" Show buffer numbers
let g:airline#extensions#tabline#buffer_nr_show = 1

" ---------- settings ---------
" We'll use a highlight color column if it has it.
if exists('+colorcolumn')
	set colorcolumn=81
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif
hi! link ColorColumn OuterSunset_pink_0_sign

" Change the color for better-whitespace plugin
let g:better_whitespace_ctermcolor='darkblue'
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help']

" <C-a> and <C-x> by default interpret leading-zero numbers as octal. I almost
" never work with octal, so this will make all numbers be interpreted as
" decimal.
set nrformats=

set mouse=a

" Filetype highlighting
filetype on
filetype plugin indent on
syntax on

" Turn on the matchit plugin that will enable jumping to pairs of things like
" matching open and close xml tags with %.
" runtime macros/matchit.vim

" Show what you are typing mid-command
set showcmd

" Indentation/tabs
set autoindent
" Turn off showing tabs. Only want this for go, but being lazy for now.
" set listchars=tab:│-
" set listchars=tab:\│\ ,trail:-,extends:>,precedes:<,nbsp:+
" set list
" highlight SpecialKey ctermfg=blue ctermbg=blue

" Settings for the ALE linter.
let g:ale_linters = {
\   'javascript': ['eslint'],
\   }
" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

" 2 spaces by default
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Except HTML - 2 spaces
autocmd BufWinEnter *.html setlocal tabstop=2
autocmd BufWinEnter *.html setlocal expandtab
autocmd BufWinEnter *.html setlocal shiftwidth=2
autocmd BufWinEnter *.html setlocal expandtab
autocmd BufWinEnter *.html setlocal colorcolumn=101
autocmd BufWinEnter *.html setlocal textwidth=100

" Java 100 characters.
autocmd BufWinEnter *.java setlocal tabstop=4
autocmd BufWinEnter *.java setlocal expandtab
autocmd BufWinEnter *.java setlocal shiftwidth=4
autocmd BufWinEnter *.java setlocal colorcolumn=101
autocmd BufWinEnter *.java setlocal textwidth=100

" Show Git blame
nnoremap <leader>gb :Git blame<CR>
" Git things with github
" https://github.com/ruanyl/vim-gh-line
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 1
let g:gh_line_map = 'ght'
let g:gh_line_blame_map = 'ghb'

" More familiar symbols for nerdtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "✹",
    \ "Untracked" : "?",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "*",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "!"
    \ }
" Close vim if the only thing left open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Color scheme and font
" My preferred version before OuterSunset.
" colorscheme xoria256
" Kyle's custom color scheme: https://github.com/malectro/outer-sunset
" colorscheme OuterSunset
" colorscheme onedark
" set termguicolors
" I like default xoria256, with a few modifications. Set those modifications
" here.
hi Comment      ctermfg=48 guifg=#808080
set guifont=Monaco:h12

" Highlight current line
set cursorline

" Statusline
set laststatus=2 " Show statusline even when there is a single window
set statusline=%F%m%r%h%w%{fugitive#statusline()}
set statusline+=[%l,%v][%p%%]

" Maintain more text around the cursor
set scrolloff=3

" Show line numbers
set number

" More intelligent backspace and left/right movement
set backspace=eol,start,indent
set whichwrap=b,s,h,l,<,>,[,]

set wrap
set textwidth=80

" Wrap git commit messages as 72 charcters. This is supposed to come with both
" fugitive and these days stock vim, but for whatever reason I'm getting
" highlighting at 50 characters in the first line, as expected, but not commit
" message wrapping.
au FileType gitcommit setlocal tw=72
au FileType gitcommit setlocal colorcolumn=73

" Wrap go at 100.
au FileType go setlocal tw=100
au FileType go setlocal colorcolumn=101

" Hidden buffer support. I think this lets us navigate away from a buffer,
" even when doing ':bnext', without giving the 'override with !' error.
set hidden

" Disable annoying messages, swap file already exists
set autoread
set shortmess+=IA

" Longer history
set history=1000
" By default the up and down arrows filter commands in the history--eg if you
" type ':e ' and then hit up, you'll see only the previous commands that
" started with that. If you do that and then hit <C-p>, however, you won't. So
" let's fix that behavior.
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Case-smart searching (case-sensitive only if capital letter in search)
set ignorecase
set smartcase

" Incremental search
set incsearch

" And we're going to add commands that remap & to :&& in normal and visual
" modes. & normally reruns the substitution without the same flags, but this
" isn't super useful, so per the advice of Practical Vim I'm going to remap it
" to just redo the same thing.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" We're also going to add a toggle for highlighting search to c-l.
" According to Practical Vim, normally <C-l> clears and redraws the creen.
" This mapping builds on top of the usual behavior by muting search
" highlighting. FOR WHATEVER REASON THIS IS NOT WORKING
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Tab completion
set wildmode=longest,list
set wildignore=*.pyc

" Visual bell instead of beep
set visualbell

" keep backups and temp files in ~.vim/
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" set default split opening position to be below and to the right of currently active split
set splitbelow
set splitright

" Tags - recursively check parent directories for tags file
set tags+=./.tags,.tags,../.tags,../../.tags

" Filetypes
autocmd BufEnter *.mako setlocal filetype=html

" Unicode stuff. This is taken from the following two places, both of which
" have good explanations:
" http://vim.wikia.com/wiki/Working_with_Unicode
" http://stackoverflow.com/questions/16507777/vim-set-encoding-and-fileencoding-utf-8
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8
	set fileencodings=ucs-bom,utf-8,latin1
endif

" Make warnings more noticeable, specially to not miss search wrap
hi WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None

" This is a function from Practical Vim that executes something for every item
" in the argument list. It is also available as a plugin, with README
" information and things here (also see the books for usage):
" https://github.com/nelstrom/vim-qargs
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" ---------- mappings ---------

" Make %% a shortcut for %:h on the command line. Normally if you do 
" ':edit %<Tab>' it will show you the relative path to the file, including the
" filename. If you don't want the filename, you do ':edit %:h<Tab>'. This
" remapping will give allow us to get the same functionality by doing
" ':edit %%'.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" set background=dark
" if exists('+guifont')
"   " set guifont=Operator\ Mono:h16
"   " set guifont=Fira\ Code:h16
"   set guifont=Space\ Mono:h14
"   " set guifont=Monaco:h14
" endif

" Remove the delay in ESC leaving a mode (ttimeoutlen)
set timeoutlen=1000 ttimeoutlen=0

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
colorscheme OuterSunset
hi! ColorColumn guibg='DarkRed'
" source ~/.vimrc
