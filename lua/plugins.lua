return {
  { "tpope/vim-fugitive" },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    -- Don't use lazy.nvim `keys` for lazy loading - leap handles it internally.
    -- See https://codeberg.org/andyg/leap.nvim#installation
    config = function()
      -- Leap's `s` default collides with MiniSurround's `sa`/`sd`/`sr`
      -- namespace, and normal Enter is not used for line movement.
      vim.keymap.set({ "n", "x", "o" }, "<CR>", "<Plug>(leap)")
      vim.keymap.set("n", "g<CR>", "<Plug>(leap-from-window)")

      local function restore_enter(buf)
        vim.keymap.set("n", "<CR>", "<CR>", { buffer = buf, silent = true, desc = "select entry" })
      end

      local group = vim.api.nvim_create_augroup("leap_enter_overrides", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "qf",
        callback = function(args)
          restore_enter(args.buf)
        end,
      })
      vim.api.nvim_create_autocmd("CmdwinEnter", {
        group = group,
        callback = function()
          restore_enter(0)
        end,
      })
    end,
  },
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle" },
    keys = {
      { "<leader>tf", "<CMD>FloatermToggle<CR>", desc = "floating terminal" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config-lualine").cfg()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>ee", "<CMD>Neotree filesystem reveal toggle<CR>", desc = "filesystem" },
      { "<leader>eb", "<CMD>Neotree buffers toggle<CR>", desc = "buffers" },
      { "<leader>eg", "<CMD>Neotree git_status toggle<CR>", desc = "git status" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        opts = {
          filter_rules = {
            autoselect_one = true,
            include_current_win = false,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "mininotify" },

              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        },
      },
    },
    config = function()
      require("config-neo-tree").cfg()
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = require("config-which-key").groups,
    },
  },
  {
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = "super-tab" },

      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        menu = {
          border = "rounded",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = {
            border = "rounded",
          },
        },
      },

      sources = {
        default = { "lsp", "path", "buffer" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },

      -- experimental auto-brackets support
      -- completion = { accept = { auto_brackets = { enabled = true } } }

      -- experimental signature help support
      -- signature = { enabled = true }
    },
  },
  {
    "romus204/tree-sitter-manager.nvim",
    config = function()
      require("tree-sitter-manager").setup({
        auto_install = true,
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
    },
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "j-hui/fidget.nvim",
    event = { "VeryLazy" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config-lsp").cfg()
    end,
  },
  { "b0o/SchemaStore.nvim" },
  {
    "mfussenegger/nvim-lint",
    ft = { "dockerfile", "markdown" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        Dockerfile = { "hadolint" },
        dockerfile = { "hadolint" },
        markdown = { "markdownlint-cli2" },
      }

      local function debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = debounce(100, function()
          lint.try_lint()
        end),
      })

      vim.schedule(function()
        lint.try_lint()
      end)
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "Format" },
    keys = {
      { "<leader>cf", "<cmd>Format<cr>", mode = { "n", "v" }, desc = "format" },
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "format injected",
      },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        html = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        yaml = { "prettier_yaml" },
        json = { "prettierd" },
        toml = { "prettierd" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500 }
      end,
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-bn" },
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })

      require("conform").setup(opts)

      -- create custom markdown formatter with prettier and longer print-width by default
      local yaml_formatter = vim.deepcopy(require("conform.formatters.prettier"))
      require("conform.util").add_formatter_args(yaml_formatter, { "--print-width", "120" }, { append = false })
      ---@cast yaml_formatter conform.FormatterConfigOverride
      require("conform").formatters.prettier_yaml = yaml_formatter
    end,
    init = function()
      local function show_notification(message, level)
        vim.notify(message, level, { title = "conform.nvim" })
      end

      vim.api.nvim_create_user_command("FormatToggle", function(args)
        local is_global = not args.bang
        if is_global then
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          if vim.g.disable_autoformat then
            show_notification("Autoformat-on-save disabled globally", vim.log.levels.INFO)
          else
            show_notification("Autoformat-on-save enabled globally", vim.log.levels.INFO)
          end
        else
          vim.b.disable_autoformat = not vim.b.disable_autoformat
          if vim.b.disable_autoformat then
            show_notification("Autoformat-on-save disabled for this buffer", vim.log.levels.INFO)
          else
            show_notification("Autoformat-on-save enabled for this buffer", vim.log.levels.INFO)
          end
        end
      end, {
        desc = "Toggle autoformat-on-save",
        bang = true,
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.starter").setup()
      require("mini.sessions").setup()
      require("mini.indentscope").setup()
      require("mini.icons").setup()
      require("mini.surround").setup()
      require("mini.trailspace").setup()
      require("mini.pairs").setup()
      require("mini.hipatterns").setup({
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        },
      })
      require("mini.input").setup()
      require("mini.notify").setup({
        lsp_progress = { enable = false },
      })
      local MiniFiles = require("mini.files")
      MiniFiles.setup({
        options = { use_as_default_explorer = false },
      })
      vim.keymap.set("n", "<leader>em", function()
        local path = vim.api.nvim_buf_get_name(0)
        MiniFiles.open(path ~= "" and path or nil)
      end, { desc = "mini files" })
      vim.keymap.set("n", "<leader>Ss", function()
        require("mini.sessions").select()
      end, { desc = "select" })
      vim.keymap.set("n", "<leader>Sn", function()
        local MiniSessions = require("mini.sessions")
        local Utils = require("utils")

        local project_path = Utils.get_git_root_or_cwd()
        local proposed_session_name = vim.fs.basename(project_path)

        Utils.input_prompt_with_default("Session name:", proposed_session_name, function(name)
          if name then
            MiniSessions.write(name)
          end
        end)
      end, { desc = "new" })
      require("mini.diff").setup({
        view = { style = "sign" },
      })

      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- For `nvim-treesitter` users.
    priority = 49,
    -- For blink.cmp's completion source
    dependencies = {
      "saghen/blink.cmp",
    },
    ft = { "markdown", "quarto", "rmd" },
    opts = {
      preview = {
        hybrid_modes = { "n" },
        filetypes = { "markdown", "quarto", "rmd" },
        icon_provider = "mini",
      },
      markdown = {
        code_blocks = {
          style = "simple",
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({ ui_select = true })
    end,
    cmd = "FzfLua",
    keys = {
      {
        "<leader>f",
        function()
          require("fzf-lua").files()
        end,
        desc = "files",
      },
      {
        "<leader>sb",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "buffers",
      },
      {
        "<leader>sB",
        function()
          require("fzf-lua").git_branches()
        end,
        desc = "git branches",
      },
      {
        "<leader>sh",
        function()
          require("fzf-lua").command_history()
        end,
        desc = "history",
      },
      {
        "<leader>sm",
        function()
          require("fzf-lua").marks()
        end,
        desc = "marks",
      },
      {
        "<leader>st",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "text",
      },
      {
        "<leader>su",
        function()
          require("fzf-lua").colorschemes()
        end,
        desc = "colorschemes",
      },
      {
        "<leader>ld",
        function()
          require("fzf-lua").diagnostics_document()
        end,
        desc = "document diagnostics",
      },
      {
        "<leader>lD",
        function()
          require("fzf-lua").diagnostics_workspace()
        end,
        desc = "workspace diagnostics",
      },
      {
        "<leader>ls",
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
        desc = "document symbols",
      },
      {
        "<leader>lS",
        function()
          require("fzf-lua").lsp_workspace_symbols()
        end,
        desc = "workspace symbols",
      },
      {
        "<leader>la",
        function()
          require("fzf-lua").lsp_code_actions()
        end,
        desc = "code actions",
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      enabled = function(root_dir)
        return vim.fs.normalize(root_dir) == vim.fs.normalize(vim.fn.stdpath("config"))
      end,
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = require("config-tiny-inline-diagnostic").cfg,
  },
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
  { "RRethy/vim-illuminate" },
  {
    "coder/claudecode.nvim",
    -- Lazy-loaded on purpose: the WebSocket server starts only when a command
    -- or keymap below is first used, never at Neovim startup.
    cmd = {
      "ClaudeCode",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeStatus",
      "ClaudeCodeFocus",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    opts = {
      -- Built-in terminal split for the embedded workflow; external sessions
      -- connect to the same server via /ide regardless of this provider.
      terminal = { provider = "native" },
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "toggle embedded Claude" },
      { "<leader>ai", "<cmd>ClaudeCodeStart<cr>", desc = "start IDE server (external /ide)" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "send selection to Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "add buffer to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "add file to Claude",
        ft = { "neo-tree", "minifiles" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "deny diff" },
    },
  },
}
