-- https://github.com/wbthomason/packer.nvim/issues/180#issuecomment-871634199
vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup({
  function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use 'lewis6991/impatient.nvim'

    -- luarocks stuff
    use_rocks 'penlight'

    -- Base plugins
    use 'tpope/vim-surround'
    use {
      'terrortylor/nvim-comment',
      config = function() require'nvim_comment'.setup() end
    }
    use {
      'editorconfig/editorconfig-vim',
      config = function()
        vim.g.EditorConfig_max_line_indicator = "none"
      end
    }
    use {
      'ntpeters/vim-better-whitespace',
      config = function()
        require("config-better-whitespace").cfg()
      end
    }
    use 'tpope/vim-fugitive'
    -- use 'dstein64/vim-startuptime'
    use {
      'zhou13/vim-easyescape',
      config = function()
        require'config-easyescape'.cfg()
      end
    }
    use 'knubie/vim-kitty-navigator'
    use {'mg979/vim-visual-multi', config = function()
      vim.g.VM_maps = {
        ["Add Cursor Down"] = "<S-Down>",
        ["Add Cursor Up"] = "<S-Up>",
      }
    end}
    use 'nathom/filetype.nvim'
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup()
      end
    }

    -- Languages
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', opt = true, cmd = 'MarkdownPreview'}
    use 'onemanstartup/vim-slim' -- faster slim syntax highlighting than the common plugin
    use 'fladson/vim-kitty'
    use 'digitaltoad/vim-pug'
    use 'kchmck/vim-coffee-script'
    use 'hashivim/vim-terraform'
    use 'dag/vim-fish'
    -- use 'elixir-editors/vim-elixir'

    -- UI
    -- use 'tpope/vim-vinegar'
    use {'liuchengxu/vista.vim', opt = true, cmd = {'Vista'}} -- Code structure view
    -- use 'dstein64/nvim-scrollview'

    -- Lightline
    -- use 'itchyny/lightline.vim'
    -- use 'itchyny/vim-gitbranch'

    use {'voldikss/vim-floaterm', opt = true, cmd = {'FloatermNew', 'FloatermToggle'}}

    -- Lualine
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = function()
        require('config-lualine').cfg()
      end
    }

    use {
      'kevinhwang91/rnvimr',
      config = function()
        require'config-rnvimr'.cfg()
      end,
      opt = true,
      cmd = 'RnvimrToggle'
    }

    use {
      'glepnir/dashboard-nvim',
      config = function()
        require"config-dashboard".cfg()
      end
    }

    use {
      'kyazdani42/nvim-tree.lua',
      config = function()
        require"config-nvim-tree".cfg()
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = function()
        require'gitsigns'.setup()
      end
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
      config = function()
        require'config-telescope'.cfg()
      end
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    use {
      'AckslD/nvim-whichkey-setup.lua',
      requires = {'liuchengxu/vim-which-key'},
      config = function()
        require"config-which-key".cfg()
      end
    }

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      requires = {'hrsh7th/nvim-cmp', opt = true}
    }
    use {
      'hrsh7th/nvim-cmp',
      requires = {'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp'},
      config = function()
        require'config-cmp'.cfg()
      end
    }
    use 'onsails/lspkind-nvim'
    use 'kosayoda/nvim-lightbulb'
    use {
      'hrsh7th/vim-vsnip',
      config = function()
        require'config-vsnip'.cfg()
      end
    }

    use 'nvim-lua/lsp-status.nvim'

    use {
      "ray-x/lsp_signature.nvim",
      requires = {'neovim/nvim-lspconfig', opt = true},
      config = function()
        require "lsp_signature".setup({
          bind = true,
          handler_opts = {
            border = "single"
          }
        })
      end
    }

    use { 'tami5/lspsaga.nvim', config = function() require'lspsaga'.setup() end }

    use {
      'windwp/nvim-autopairs',
      config = function()
        require'config-autopairs'.cfg()
      end
    }

    use {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require('neoclip').setup()
      end
    }

    use {
      'folke/trouble.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      opt = true,
      cmd = {'Trouble', 'TroubleToggle'},
      config = function()
        require'config-trouble'.cfg()
      end
    }

    -- barbar
    -- use 'kyazdani42/nvim-web-devicons'
    -- use 'romgrk/barbar.nvim'

--     -- bufferline
--     use {
--       'akinsho/nvim-bufferline.lua',
--       requires = 'kyazdani42/nvim-web-devicons',
--       config = function()
--         require'config-bufferline'.cfg()
--       end
--     }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require'config-treesitter'.cfg()
      end
    }

    -- Colors
    use 'bluz71/vim-nightfly-guicolors'
    use 'sainnhe/edge'

    use {
      'folke/tokyonight.nvim',
      requires = {{"hoob3rt/lualine.nvim", opt = true}},
      config = function()
        require('theme').cfg_theme()
      end
    }

    use {
      'projekt0n/github-nvim-theme',
      requires = {{"hoob3rt/lualine.nvim", opt = true}},
      config = function()
        require('theme').cfg_theme()
      end
    }

    use 'mfussenegger/nvim-dap'
    use{'mfussenegger/nvim-dap-python', config = function() require'config-dap-python'.cfg() end}

    use {
      'williamboman/nvim-lsp-installer',
      requires = {'neovim/nvim-lspconfig', opt = true},
      config = function()
        require'lsp'.cfg()
      end
    }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = {{'neovim/nvim-lspconfig', opt = true}, {'nvim-lua/plenary.nvim', opt = true}}
    }

    -- use 'github/copilot.vim'
  end, config = {compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'}
});
