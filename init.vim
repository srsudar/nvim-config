" TODO
" trouble?

" Load Packer plugins
lua require('plugins')
lua require('kickstart')


"
" Behavior Configuration
" ----------------------

set tabstop=2                   " Tab settings

set autoread                    " No prompt for file changes outside Vim
set noswapfile                  " No swap file
set nobackup                    " No backup file
set nowritebackup


"
" Mappings
" --------

" Special key for prefixing helpful commands
let mapleader = ","

" Reload .vimrc
map <leader>rv  :source ~/.config/nvim/init.vim<CR>

" Change directory to current file
map <Leader>cd :lcd %:p:h<CR>


"
" Colors and UI
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
