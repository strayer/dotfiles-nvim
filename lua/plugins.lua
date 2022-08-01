-- https://github.com/wbthomason/packer.nvim/issues/180#issuecomment-871634199
vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- luarocks stuff
    use_rocks("penlight")

    -- Base plugins
    use("tpope/vim-surround")
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })
    use({
      "editorconfig/editorconfig-vim",
      config = function()
        vim.g.EditorConfig_max_line_indicator = "none"
      end,
    })
    use({
      "ntpeters/vim-better-whitespace",
      config = function()
        require("config-better-whitespace").cfg()
      end,
    })
    use("tpope/vim-fugitive")
    use({
      "zhou13/vim-easyescape",
      config = function()
        require("config-easyescape").cfg()
      end,
    })
    use("knubie/vim-kitty-navigator")
    use({
      "mg979/vim-visual-multi",
      config = function()
        vim.g.VM_maps = {
          ["Add Cursor Down"] = "<S-Down>",
          ["Add Cursor Up"] = "<S-Up>",
        }
      end,
    })
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup()
      end,
    })

    -- Languages
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      cmd = "MarkdownPreview",
      config = function()
        vim.cmd("doautocmd mkdp_init BufEnter")
      end,
    })
    use("onemanstartup/vim-slim") -- faster slim syntax highlighting than the common plugin
    use("fladson/vim-kitty")
    use("hashivim/vim-terraform")
    use("dag/vim-fish")
    use("pearofducks/ansible-vim")

    use("ggandor/lightspeed.nvim")

    use({ "voldikss/vim-floaterm", opt = true, cmd = { "FloatermNew", "FloatermToggle" } })

    -- Lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      after = { "github-nvim-theme", "tokyonight.nvim" },
      config = function()
        require("config-lualine").cfg()
      end,
    })
    use("arkav/lualine-lsp-progress")

    use({
      "kevinhwang91/rnvimr",
      config = function()
        require("config-rnvimr").cfg()
      end,
      opt = true,
      cmd = "RnvimrToggle",
    })

    use({
      "glepnir/dashboard-nvim",
      config = function()
        require("config-dashboard").cfg()
      end,
    })

    use({
      "nvim-neo-tree/neo-tree.nvim",
      branch = "main",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        {
          -- only needed if you want to use the commands with "_with_window_picker" suffix
          "s1n7ax/nvim-window-picker",
          tag = "1.*",
          config = function()
            require("window-picker").setup({
              autoselect_one = true,
              include_current = false,
              filter_rules = {
                -- filter using buffer options
                bo = {
                  -- if the file type is one of following, the window will be ignored
                  filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

                  -- if the buffer type is one of following, the window will be ignored
                  buftype = { "terminal" },
                },
              },
              other_win_hl_color = "#e35e4f",
            })
          end,
        },
      },
      config = function()
        require("config-neo-tree").cfg()
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gitsigns").setup()
      end,
    })

    use({
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
      config = function()
        require("config-telescope").cfg()
      end,
    })
    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })

    use({
      "folke/which-key.nvim",
      config = function()
        require("config-which-key").cfg()
      end,
    })

    -- LSP
    use({
      "neovim/nvim-lspconfig",
      requires = { "hrsh7th/nvim-cmp", opt = true },
    })
    use({
      "hrsh7th/nvim-cmp",
      requires = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-vsnip" },
      config = function()
        require("config-cmp").cfg()
      end,
    })
    use("onsails/lspkind-nvim")
    use("kosayoda/nvim-lightbulb")
    use({
      "hrsh7th/vim-vsnip",
      config = function()
        require("config-vsnip").cfg()
      end,
    })

    use({
      "ray-x/lsp_signature.nvim",
      requires = { "neovim/nvim-lspconfig", opt = true },
      config = function()
        require("lsp_signature").setup({
          bind = true,
          handler_opts = {
            border = "single",
          },
        })
      end,
    })

    use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
        local saga = require("lspsaga")

        saga.init_lsp_saga({
          -- your configuration
        })
      end,
    })

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("config-autopairs").cfg()
      end,
    })

    use({
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup()
      end,
    })

    use({
      "folke/trouble.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      opt = true,
      cmd = { "Trouble", "TroubleToggle" },
      config = function()
        require("config-trouble").cfg()
      end,
    })

    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("config-treesitter").cfg()
      end,
    })

    -- Colors
    use({
      "projekt0n/github-nvim-theme",
      requires = { { "hoob3rt/lualine.nvim", opt = true } },
    })
    use("folke/tokyonight.nvim")

    use("mfussenegger/nvim-dap")
    use({
      "mfussenegger/nvim-dap-python",
      config = function()
        require("config-dap-python").cfg()
      end,
    })

    use({
      "williamboman/nvim-lsp-installer",
      requires = { "neovim/nvim-lspconfig", opt = true },
      config = function()
        require("lsp").cfg()
      end,
    })
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = { { "neovim/nvim-lspconfig", opt = true }, { "nvim-lua/plenary.nvim", opt = true } },
    })

    use({
      "cuducos/yaml.nvim",
      ft = { "yaml" }, -- optional
      requires = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim", -- optional
      },
    })

    use({
      "cormacrelf/dark-notify",
      config = function()
        require("dark_notify").run({
          onchange = function(mode)
            if mode == "light" then
              require("github-theme").setup({
                dark_float = true,
                dark_sidebar = true,
                sidebars = { "packer" },
                theme_style = "light",
              })
            else
              vim.cmd([[colorscheme tokyonight]])
            end
            require("lualine").setup()
          end,
        })
      end,
    })
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
