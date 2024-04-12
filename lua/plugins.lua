return {
  { "tpope/vim-surround" },
  { "numToStr/Comment.nvim", opts = {} },
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
  { "fladson/vim-kitty" },
  { "dag/vim-fish" },
  { "pearofducks/ansible-vim" },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    event = "VeryLazy",
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
    cmd = "Neotree",
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
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("config-which-key").cfg()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp" },
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
      { "nvim-tree/nvim-web-devicons" },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
      -- lua_ls setup for Neovim (configured in config-lsp.lua)
      "folke/neodev.nvim",
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
    event = "BufEnter",
    opts = {
      -- your options here
    },
  },
  {
    "Vimjas/vim-python-pep8-indent",
  },
  { "shortcuts/no-neck-pain.nvim", version = "*" },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    ft = "markdown",
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
}
