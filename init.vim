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

" make ctrl+c work 
" set clipboard=unnamed
" set clipboard+=unnamedplus
" vnoremap <C-c>  "+y
" vnoremap <C-c> "*y

" colorscheme molokai
" colorscheme OuterSunset
" if has('termguicolors')
"   set t_Co=256
"   set termguicolors
"   " colorscheme OceanicNext
"   " colorscheme ayu
"   " colorscheme onedark
"   " let g:onedark_terminal_italics = 1
"   " colorscheme gruvbox
"   " let g:gruvbox_contrast_dark = 'hard'
"   " colorscheme dracula
" endif
"
" set background=dark
" if exists('+guifont')
"   " set guifont=Operator\ Mono:h16
"   " set guifont=Fira\ Code:h16
"   set guifont=Space\ Mono:h14
"   " set guifont=Monaco:h14
" endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
