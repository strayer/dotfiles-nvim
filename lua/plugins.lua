-- https://github.com/wbthomason/packer.nvim/issues/180#issuecomment-871634199
vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup({
  function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- luarocks stuff
    use_rocks 'penlight'

    -- Base plugins
    use 'tpope/vim-surround'
    use 'b3nj5m1n/kommentary'
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

    -- Languages
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', opt = true, cmd = 'MarkdownPreview'}
    use 'onemanstartup/vim-slim' -- faster slim syntax highlighting than the common plugin
    use 'fladson/vim-kitty'
    use 'digitaltoad/vim-pug'
    use 'kchmck/vim-coffee-script'
    use 'ekalinin/Dockerfile.vim'
    use 'hashivim/vim-terraform'
    use 'dag/vim-fish'

    -- UI
    use 'tpope/vim-vinegar'
    use {'liuchengxu/vista.vim', opt = true, cmd = {'Vista'}} -- Code structure view
    -- use 'dstein64/nvim-scrollview'

    -- Lightline
    -- use 'itchyny/lightline.vim'
    -- use 'itchyny/vim-gitbranch'

    -- Lualine
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = {require('lualine').setup {options = {theme = 'tokyonight'}}}
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
    use 'neovim/nvim-lspconfig'
    use {'kabouzeid/nvim-lspinstall', config = function() require'lsp'.setup_servers() end}
    use {
      'hrsh7th/nvim-compe',
      config = function()
        require'config-compe'.cfg()
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
    use {"glepnir/lspsaga.nvim"}

    use {
      'windwp/nvim-autopairs',
      config = function()
        require'config-autopairs'.cfg()
      end
    }

    -- barbar
    -- use 'kyazdani42/nvim-web-devicons'
    -- use 'romgrk/barbar.nvim'

    -- bufferline
    use {
      'akinsho/nvim-bufferline.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require'config-bufferline'.cfg()
      end
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require'config-treesitter'.cfg()
      end
    }

    -- Colors
    use 'bluz71/vim-nightfly-guicolors'
    use 'folke/tokyonight.nvim'
    use 'sainnhe/edge'
    use 'projekt0n/github-nvim-theme'
  end
});
