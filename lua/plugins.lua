-- Don't forget that packer gets installed at
-- ~/.local/share/nvim/site

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- NB: various Packer commands fail with too many open files for me. I can fix
-- this by setting `ulimit -n 10240`, though I might have to do that per-shell.
-- See: https://github.com/wbthomason/packer.nvim/issues/1199.
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  -- use 'williamboman/mason.nvim'
  -- use 'williamboman/mason-lspconfig.nvim'
  -- this claims to be faster than the default typescript server
  -- use {
  --   "pmizio/typescript-tools.nvim",
  --   requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   config = function()
  --     require("typescript-tools").setup {}
  --   end,
  -- }
  use {
    'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
    config = function()
      require('Comment').setup()
    end
  }
  -- NOTE (kyle): not sure what the point of this is
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  -- use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
    -- run = ':TSUpdate',
    config = function()
      -- Treesitter configuration
      -- Parsers must be installed manually via :TSInstall
      require('nvim-treesitter.configs').setup {
--	      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "TypeScript" }
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
        playground = {
          enable = false,
        },
      }
    end
  }
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'malectro/outer-sunset'
  use 'joshdick/onedark.vim'
  use 'rebelot/kanagawa.nvim'
  use 'catppuccin/nvim'
  use 'folke/tokyonight.nvim'
  use 'sainnhe/sonokai'
  use 'sainnhe/everforest'
  use 'EdenEast/nightfox.nvim'
  use 'rose-pine/neovim'
  use 'shaunsingh/nord.nvim'
  use 'junegunn/seoul256.vim'
  use 'sbdchd/neoformat'
  use 'ggandor/leap.nvim'
  use 'github/copilot.vim'
  use 'ruanyl/vim-gh-line'
  use 'hashivim/vim-terraform'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  -- use 'ludovicchabant/vim-gutentags'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local lspconfig = require 'lspconfig'
      require("null-ls").setup {
        sources = {
          require("null-ls").builtins.formatting.prettier.with({
            filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'less', 'json' },
          }),
          require("null-ls").builtins.diagnostics.eslint,
          require("null-ls").builtins.formatting.black,
          require("null-ls").builtins.diagnostics.mypy,
          require("null-ls").builtins.formatting.gofmt,
          require("null-ls").builtins.formatting.rustfmt,
          require("null-ls").builtins.formatting.deno_fmt,
        },
        root_dir = lspconfig.util.root_pattern(".prettierrc"),
      }
    end,
    requires = { "nvim-lua/plenary.nvim" },
  }
  --use {
  --  "nvim-neo-tree/neo-tree.nvim",
  --  requires = {
  --    "nvim-lua/plenary.nvim",
  --    -- enabling this requires a patched font
  --    -- "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
  --    "MunifTanjim/nui.nvim"
  --  },
  --}
  -- fzf for searching
  use {
    'junegunn/fzf.vim',
    requires = { 'junegunn/fzf', run = ':call fzf#install()' }
 }
  -- We need pseudocli for some of junegunn's other plugins
  use 'junegunn/vim-pseudocl'
  -- search with ack
  use 'mileszs/ack.vim'
  -- async builds
  use 'tpope/vim-dispatch'
  -- file browser on the left
  -- use 'scrooloose/nerdtree'
  -- and make the nerdtree file browser consistent between tabs
  -- use 'jistr/vim-nerdtree-tabs'
  -- and show git flags
  -- use 'Xuyuanp/nerdtree-git-plugin'
  -- more python support
  -- Plug 'klen/python-mode'
  -- surround things with other things
  use 'tpope/vim-surround'
  -- syntax highlighting
  -- Plug 'dense-analysis/ale'
  -- complementary mappings
  use 'tpope/vim-unimpaired'
  -- more sane regex
  use 'nelstrom/vim-visual-star-search'
  -- open alternate files (eg foo.h quick opens foo.c)
  use 'vim-scripts/a.vim'
  -- show git status of lines
  use 'airblade/vim-gitgutter'
  -- Smart alignment of text.
  use 'junegunn/vim-easy-align'
  -- Use ctrl+h,j,k,l to navigate tmux and vim windows
  use 'christoomey/vim-tmux-navigator'
  -- Use github-flavored markdown highlighting, not canonical md highlighthing
  -- Plug 'jtratner/vim-flavored-markdown'
  -- Prettier status line.
  -- Plug 'vim-airline/vim-airline'
  -- Plug 'vim-airline/vim-airline-themes'
  -- Commenting with gc{motion}
  use 'tomtom/tcomment_vim'
  -- Define custom text objects. Required for vim-textobj-entire
  -- use 'kana/vim-textobj-user'
  -- Add 'whole file' objects with ae and ie (ignores leading/trailing whitespace)
  -- use 'kana/vim-textobj-entire'
  -- Allow . repeating using vim-surround
  use 'tpope/vim-repeat'
  -- Smarter CTRL-A and CTRL-X for addition/subtraction
  use 'tpope/vim-speeddating'
  -- Auto-conversion to snake, camel, mixed, upper  case with crs, crc, crm, cru
  --   NB: converting out of dash case, eg foo-bar, doesn't work because it is
  --   blocked by vim's `iskeyword` definition. See: tpope/vim-abolish/issues/64
  use 'tpope/vim-abolish'
  -- Allow smarter pasting.
  use 'svermeulen/vim-easyclip'
  -- Word objects for columns of text
  -- use 'coderifous/textobj-word-column.vim'
  -- latex support
  use 'lervag/vimtex'
  -- Readline-style bindings in vim
  use 'tpope/vim-rsi'
  -- More information for <ctrl>+a character information, including unicode
  use 'tpope/vim-characterize'
  -- Fancy pants auto completion
  -- Plug 'ycm-core/YouCompleteMe'
  -- Plug 'neoclide/coc.nvim', {'branch': 'release'}
  -- Color TOML
  use 'cespare/vim-toml'
  -- Better markdown support. Need tabular and vim-markdown
  use 'godlygeek/tabular'
  -- markdown
  -- Plug 'srsudar/vim-markdown'
  -- Plug 'gabrielelana/vim-markdown'
  -- use 'plasticboy/vim-markdown'
  -- Better searching and highlighting defaults.
  use 'junegunn/vim-oblique'
  -- Show contents of registers using " and @ in insert and <C-CR> in insert
  use 'junegunn/vim-peekaboo'
  -- Browse git commits. fugitive must be installed first.
  -- :GV to open commit browser
  -- :GV! will only list commits for the current file
  -- :GV over visual range will list commits for the lines
  -- You can pass git log options to the command, e.g. :GV -S foobar.
  use 'junegunn/gv.vim'
  -- Tmux integration like writing to another pane.
  -- Plug 'tpope/vim-tbone'
  -- Show indentation levels with :IndentLinesToggle
  use 'Yggdroot/indentLine'
  -- Open the current file[pwd] in finder with go{f,F}.
  use 'justinmk/vim-gtfo'
  -- Highlighting for docker files
  use 'honza/dockerfile.vim'
  -- Help with unicode digraphs
  use 'chrisbra/unicode.vim'
  -- Polymer support
  -- Plug 'webdesus/polymer-ide.vim'
  -- Title Case operator with gt
  use 'christoomey/vim-titlecase'
  -- Snippets engine
  use 'SirVer/ultisnips'
  -- Snippet starers
  use 'honza/vim-snippets'
  -- Try to fix snippet suggestion
  -- use 'ervandew/supertab'
  -- json text objects with aj and ij
  use 'tpope/vim-jdaddy'
  -- Whitespace support
  use 'ntpeters/vim-better-whitespace'
  -- Dart support
  use 'dart-lang/dart-vim-plugin'
  use 'natebosch/vim-lsc'
  use 'natebosch/vim-lsc-dart'
  use 'natebosch/dartlang-snippets'
  -- use 'google/vim-maktaba'
  -- use 'google/vim-codefmt'
  -- Glaive is needed for maktaba's flags. Use `:help :Glaive` for more. Also see
  -- Glaive install command below.
  -- use 'google/vim-glaive'
  -- more language packs. In general this seems to supercede other language packs.
  -- Plug 'sheerun/vim-polyglot'
  -- No need to `:set paste`.
  use 'ConradIrwin/vim-bracketed-paste'
  -- Tagbar to see class outlines.
  use 'preservim/tagbar'
  -- Tmux integration
  use 'preservim/vimux'
  -- Better cpp highlighting.
  use 'octol/vim-cpp-enhanced-highlight'
  -- This mostly doesn't work thanks to TS. You can get it working with
  -- `:TSBufDisable highlight`.
  -- use 'luochen1990/rainbow'
  -- For clojure.
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  -- This is recommended by this guy, evaluating stuff in real-time, but I don't
  -- really get it so turning it off.
  -- https://endot.org/2023/05/27/vim-clojure-dev-2023/
  -- use 'Olical/conjure'
  use 'andymass/vim-matchup'
    -- Automatically set up your configuration after cloning packer.nvim

  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
