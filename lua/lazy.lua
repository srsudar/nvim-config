-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- NB: various Packer commands fail with too many open files for me. I can fix
-- this by setting `ulimit -n 10240`, though I might have to do that per-shell.
-- See: https://github.com/wbthomason/packer.nvim/issues/1199.
return require('lazy').setup({
  'tpope/vim-fugitive',     -- Git commands in nvim
  'tpope/vim-rhubarb',      -- Fugitive-companion to interact with github
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
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup()
    end
  },
  -- NOTE (kyle): not sure what the point of this is
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  -- use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  'mjlbach/onedark.nvim', -- Theme inspired by Atom
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Add git related info in the signs columns and popups
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufReadPre',
    config = function()
      require('gitsigns').setup()
    end
  },
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
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
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
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
  },
  -- Additional textobjects for treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/playground',
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  'hrsh7th/nvim-cmp', -- Autocompletion plugin
  'hrsh7th/cmp-nvim-lsp',
  'saadparwaiz1/cmp_luasnip',
  'L3MON4D3/LuaSnip', -- Snippets plugin
  'malectro/outer-sunset',
  'joshdick/onedark.vim',
  'rebelot/kanagawa.nvim',
  'catppuccin/nvim',
  'folke/tokyonight.nvim',
  'sainnhe/sonokai',
  'sainnhe/everforest',
  'EdenEast/nightfox.nvim',
  'rose-pine/neovim',
  'shaunsingh/nord.nvim',
  'junegunn/seoul256.vim',
  'sbdchd/neoformat',
  'ggandor/leap.nvim',
  'github/copilot.vim',
  'ruanyl/vim-gh-line',
  'hashivim/vim-terraform',
  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufReadPre',
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
    end
  },
  -- fzf for searching
  {
    'junegunn/fzf.vim',
    dependencies = {
      {
        'junegunn/fzf',
        build = ':call fzf#install()',
      }
    },
    event = 'VeryLazy'
  },
  -- We need pseudocli for some of junegunn's other plugins
  'junegunn/vim-pseudocl',
  -- search with ack
  'mileszs/ack.vim',
  -- async builds
  'tpope/vim-dispatch',
  -- surround things with other things
  'tpope/vim-surround',
  -- complementary mappings
  'tpope/vim-unimpaired',
  -- more sane regex
  'nelstrom/vim-visual-star-search',
  -- open alternate files (eg foo.h quick opens foo.c)
  'vim-scripts/a.vim',
  -- show git status of lines
  -- 'airblade/vim-gitgutter',
  -- Smart alignment of text.
  'junegunn/vim-easy-align',
  -- Use ctrl+h,j,k,l to navigate tmux and vim windows
  'christoomey/vim-tmux-navigator',
  -- Use github-flavored markdown highlighting, not canonical md highlighthing
  -- Plug 'jtratner/vim-flavored-markdown'
  -- Prettier status line.
  -- Plug 'vim-airline/vim-airline'
  -- Plug 'vim-airline/vim-airline-themes'
  -- Commenting with gc{motion}
  'tomtom/tcomment_vim',
  -- Define custom text objects. Required for vim-textobj-entire
  -- use 'kana/vim-textobj-user'
  -- Add 'whole file' objects with ae and ie (ignores leading/trailing whitespace)
  -- use 'kana/vim-textobj-entire'
  -- Allow . repeating using vim-surround
  'tpope/vim-repeat',
  -- Smarter CTRL-A and CTRL-X for addition/subtraction
  'tpope/vim-speeddating',
  -- Auto-conversion to snake, camel, mixed, upper  case with crs, crc, crm, cru
  --   NB: converting out of dash case, eg foo-bar, doesn't work because it is
  --   blocked by vim's `iskeyword` definition. See: tpope/vim-abolish/issues/64
  'tpope/vim-abolish',
  -- Allow smarter pasting.
  'svermeulen/vim-easyclip',
  -- Word objects for columns of text
  -- use 'coderifous/textobj-word-column.vim'
  -- latex support
  'lervag/vimtex',
  -- Readline-style bindings in vim
  'tpope/vim-rsi',
  -- More information for <ctrl>+a character information, including unicode
  'tpope/vim-characterize',
  -- Better markdown support. Need tabular and vim-markdown
  'godlygeek/tabular',
  -- markdown
  -- Plug 'srsudar/vim-markdown'
  -- Plug 'gabrielelana/vim-markdown'
  -- use 'plasticboy/vim-markdown'
  -- Better searching and highlighting defaults.
  'junegunn/vim-slash',
  -- Show contents of registers using " and @ in insert and <C-CR> in insert
  'junegunn/vim-peekaboo',
  -- Browse git commits. fugitive must be installed first.
  -- :GV to open commit browser
  -- :GV! will only list commits for the current file
  -- :GV over visual range will list commits for the lines
  -- You can pass git log options to the command, e.g. :GV -S foobar.
  'junegunn/gv.vim',
  -- Tmux integration like writing to another pane.
  -- Plug 'tpope/vim-tbone'
  -- Show indentation levels with :IndentLinesToggle
  'Yggdroot/indentLine',
  -- Open the current file[pwd] in finder with go{f,F}.
  'justinmk/vim-gtfo',
  -- Highlighting for docker files
  'honza/dockerfile.vim',
  -- Help with unicode digraphs
  'chrisbra/unicode.vim',
  -- Polymer support
  -- Plug 'webdesus/polymer-ide.vim'
  -- Title Case operator with gt
  'christoomey/vim-titlecase',
  -- Snippets engine
  'SirVer/ultisnips',
  -- Snippet starers
  'honza/vim-snippets',
  -- Try to fix snippet suggestion
  -- use 'ervandew/supertab'
  -- json text objects with aj and ij
  'tpope/vim-jdaddy',
  -- Whitespace support
  'ntpeters/vim-better-whitespace',
  -- Dart support
  'dart-lang/dart-vim-plugin',
  'natebosch/vim-lsc',
  'natebosch/vim-lsc-dart',
  'natebosch/dartlang-snippets',
  -- use 'google/vim-maktaba'
  -- use 'google/vim-codefmt'
  -- Glaive is needed for maktaba's flags. Use `:help :Glaive` for more. Also see
  -- Glaive install command below.
  -- use 'google/vim-glaive'
  -- more language packs. In general this seems to supercede other language packs.
  -- Plug 'sheerun/vim-polyglot'
  -- No need to `:set paste`.
  'ConradIrwin/vim-bracketed-paste',
  -- Tagbar to see class outlines.
  'preservim/tagbar',
  -- Tmux integration
  'preservim/vimux',
  -- Better cpp highlighting.
  'octol/vim-cpp-enhanced-highlight',
  -- This mostly doesn't work thanks to TS. You can get it working with
  -- `:TSBufDisable highlight`.
  -- use 'luochen1990/rainbow'
  -- For clojure.
  'guns/vim-sexp',
  'tpope/vim-sexp-mappings-for-regular-people',
  -- This is recommended by this guy, evaluating stuff in real-time, but I don't
  -- really get it so turning it off.
  -- https://endot.org/2023/05/27/vim-clojure-dev-2023/
  -- use 'Olical/conjure'
  'andymass/vim-matchup',
    -- Automatically set up your configuration after cloning packer.nvim
})
