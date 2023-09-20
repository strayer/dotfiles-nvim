return {
  { "tpope/vim-surround" },
  { "numToStr/Comment.nvim" },
  {
    "editorconfig/editorconfig-vim",
    config = function()
      vim.g.EditorConfig_max_line_indicator = "none"
    end,
  },
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      require("config-better-whitespace").cfg()
    end,
  },
  { "tpope/vim-fugitive" },
  {
    "zhou13/vim-easyescape",
    config = function()
      require("config-easyescape").cfg()
    end,
  },
  { "knubie/vim-kitty-navigator" },
  {
    "mg979/vim-visual-multi",
    config = function()
      vim.g.VM_maps = {
        ["Add Cursor Down"] = "<S-Down>",
        ["Add Cursor Up"] = "<S-Up>",
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    cmd = "MarkdownPreview",
    config = function()
      vim.cmd("doautocmd mkdp_init BufEnter")
    end,
  },
  { "onemanstartup/vim-slim" }, -- faster slim syntax highlighting than the common plugin
  { "fladson/vim-kitty" },
  { "hashivim/vim-terraform" },
  { "dag/vim-fish" },
  { "pearofducks/ansible-vim" },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config-lualine").cfg()
    end,
  },
  { "arkav/lualine-lsp-progress" },

  {
    "kevinhwang91/rnvimr",
    config = function()
      require("config-rnvimr").cfg()
    end,
    cmd = "RnvimrToggle",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
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
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("config-telescope").cfg()
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("config-which-key").cfg()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-vsnip" },
    config = function()
      require("config-cmp").cfg()
    end,
  },
  { "onsails/lspkind-nvim" },
  { "kosayoda/nvim-lightbulb" },
  {
    "hrsh7th/vim-vsnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("config-vsnip").cfg()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "single",
        },
      })
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("config-autopairs").cfg()
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      require("config-trouble").cfg()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("config-treesitter").cfg()
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
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
  },
  { "mfussenegger/nvim-dap" },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("config-dap-python").cfg()
    end,
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config-lsp").cfg()
    end,
  },
  { "b0o/SchemaStore.nvim" },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
  {
    "ojroques/nvim-osc52",
    config = function()
      local function copy(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
      end

      local function paste()
        return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
      end

      vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
      }

      vim.keymap.set(
        "n",
        "<leader>c",
        require("osc52").copy_operator,
        { expr = true, desc = "Copy given text to clipboard (OSC52)" }
      )
      vim.keymap.set("n", "<leader>cc", "<leader>c_", { remap = true, desc = "Copy current line to clipboard (OSC52)" })
      vim.keymap.set("x", "<leader>c", require("osc52").copy_visual, { desc = "Copy selection to clipboard (OSC52)" })
    end,
  },
  { "echasnovski/mini.nvim", version = false },
  { "rcarriga/nvim-notify" },
  {
    'isobit/vim-caddyfile',
    ft = { "caddyfile" }
  },
}
