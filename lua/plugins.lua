return {
  { "tpope/vim-surround" },
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      require("config-better-whitespace").cfg()
    end,
  },
  { "tpope/vim-fugitive" },
  {
    "numToStr/Navigator.nvim",
    config = function()
      vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
      vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
      vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
      vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
      vim.keymap.set({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")

      require("Navigator").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    cmd = "MarkdownPreview",
    config = function()
      vim.cmd("doautocmd mkdp_init BufEnter")
    end,
  },
  { "dag/vim-fish" },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    config = function()
      require("leap").set_default_keymaps()
    end,
  },
  { "voldikss/vim-floaterm", cmd = { "FloatermNew", "FloatermToggle" } },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config-lualine").cfg()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "1.*",
        opts = {
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
        },
      },
    },
    config = function()
      require("config-neo-tree").cfg()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = true,
    keys = require("config-which-key").keys,
    config = function()
      local wk = require("which-key")
      wk.setup()
      require("config-gp").setup_whichkey(wk)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp" },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("config-cmp").cfg()
    end,
  },
  -- vscode-like pictograms in lsp completions
  { "onsails/lspkind-nvim" },
  -- TODO: validate what features of lspsaga I'm actually using
  {
    "nvimdev/lspsaga.nvim",
    branch = "main",
    opts = {
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = { enable = false },
    },
    event = "LspAttach",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "kosayoda/nvim-lightbulb",
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- wisely add "end" in Ruby, Lua, Vimscript, etc.
  { "RRethy/nvim-treesitter-endwise" },
  {
    "AckslD/nvim-neoclip.lua",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      require("config-trouble").cfg()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("config-treesitter").cfg()
    end,
    build = ":TSUpdate",
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    dependencies = { { "nvim-lualine/lualine.nvim" } },
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = { variant = "auto" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mfussenegger/nvim-dap-python" },
    config = function()
      require("config-dap-python").cfg()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config-lsp").cfg()
    end,
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
    },
  },
  { "b0o/SchemaStore.nvim" },
  {
    "creativenull/efmls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "YAMLView",
      "YAMLYank",
      "YAMLYankKey",
      "YAMLYankValue",
      "YAMLQuickfix",
      "YAMLTelescope",
    },
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.starter").setup()
      require("mini.sessions").setup()
      require("mini.indentscope").setup()
      require("mini.icons").setup()

      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    "isobit/vim-caddyfile",
    ft = { "caddyfile" },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },

    init = function()
      -- UFO folding
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },
  {
    "folke/noice.nvim",
    -- Noice currently causes issues on exit, waiting for fix:
    -- https://github.com/folke/noice.nvim/issues/921
    commit = "d9328ef903168b6f52385a751eb384ae7e906c6f",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      -- your options here
    },
  },
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },
  { "shortcuts/no-neck-pain.nvim", version = "*", cmd = "NoNeckPain" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
      -- heading = {
      --   backgrounds = nil,
      -- },
      -- code = {
      --   style = "language",
      -- }
    },
    ft = { "markdown", "Avante" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
  },
  {
    "ibhagwan/fzf-lua",
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
    cmd = "FzfLua",
    keys = {
      { "<Leader><Space>", "<CMD>lua require('fzf-lua').files()<CR>", noremap = true, silent = true },
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Library items can be absolute paths
        -- "~/projects/my-awesome-lib",
        -- Or relative, which means they will be resolved as a plugin
        -- "LazyVim",
        -- When relative, you can also provide a path to the library in the plugin dir
        "luvit-meta/library", -- see below
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typing
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = require("config-tiny-inline-diagnostic").cfg,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- no lazy-loading, author doesn't recommend it and it caused problems with
    -- oil-ssh for me
  },
  {
    "garymjr/nvim-snippets",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      friendly_snippets = true,
      ignored_filetypes = { "ps1" },
    },
  },
  {
    "ejrichards/mise.nvim",
    opts = {},
    cond = vim.g.neovide == true,
  },
  { -- better vim.ui.select
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup(require("config-gp").config())
      require("config-gp").setup_autocommand()
    end,
    -- event = "VeryLazy", -- TODO: add all commands here
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = require("config-avante").config(),
    build = ":AvanteBuild", -- Also note that this will block the startup for a bit since we are compiling bindings in Rust.
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.icons",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      "MeanderingProgrammer/render-markdown.nvim",
    },
  },
}
