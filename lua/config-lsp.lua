local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = {
    noremap = true,
    silent = true,
  }
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
end

local function cfg()
  vim.api.nvim_create_user_command("LspFormat", function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= "tsserver" and client.name ~= "volar"
      end,
      timeout_ms = 4000,
    })
  end, { nargs = 0 })

  -- vim.cmd([[
  --   command! -nargs=0 LspFormat :lua vim.lsp.buf.formatting()
  -- ]])

  -- setup lspkind
  require("lspkind").init()

  -- setup cmp
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  require("mason").setup()
  require("mason-lspconfig").setup()
  local lspconfig = require("lspconfig")

  local lsp_servers = {
    "ansiblels",
    "bashls",
    "dockerls",
    "dprint",
    "eslint",
    "emmet_ls",
    "basedpyright",
    "lua_ls",
    "terraformls",
    "tflint",
    -- "tsserver",
    -- "vuels",
    "volar",
    "yamlls",
    "solargraph",
    "jsonls",
    "gopls",
    "powershell_es",
    "efm",
    "ruff",
  }
  for _, server in ipairs(lsp_servers) do
    -- default lsp opts
    local opts = {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
      capabilities = capabilities,
    }

    -- if server == "solargraph" then
    --   opts.init_options = {
    --     formatting = false,
    --   }
    --   opts.settings = {
    --     solargraph = {
    --       diagnostics = false,
    --       formatting = false,
    --     },
    --   }
    -- end

    if server == "lua_ls" then
      opts.settings = {
        workspace = { checkThirdParth = false },
        telemetry = {
          enable = false,
        },
      }
    end

    if server == "ansiblels" then
      -- default includes yaml
      opts.filetypes = { "yaml.ansible" }

      opts.settings = {
        ansible = {
          ansibleLint = {
            enabled = true,
            arguments = "",
          },
        },
        ansibleServer = {
          trace = {
            server = "verbose",
          },
        },
      }
    end

    if server == "volar" then
      opts.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }
    end

    if server == "jsonls" then
      opts.settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      }
    end

    if server == "yamlls" then
      opts.settings = {
        redhat = {
          telemetry = {
            enabled = false,
          },
        },
        yaml = {
          schemas = require("schemastore").yaml.schemas(),
          schemaStore = {
            -- disable internal schema store for b0o/SchemaStore.nvim
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = "",
          },
        },
      }
    end

    if server == "dprint" then
      opts.filetypes = { "toml" }
    end

    if server == "efm" then
      local shfmt = require("efmls-configs.formatters.shfmt")
      local hadolint = require("efmls-configs.linters.hadolint")
      local prettier_d = require("efmls-configs.formatters.prettier_d")
      local markdownlint = require("efmls-configs.linters.markdownlint")
      local stylua = require("efmls-configs.formatters.stylua")
      local terraform_fmt = require("efmls-configs.formatters.terraform_fmt")

      -- override shfmt parameters
      shfmt = vim.tbl_extend("force", shfmt, {
        formatCommand = "shfmt -i 2 -bn -kp",
      })

      local languages = {
        sh = { shfmt },
        Dockerfile = { hadolint },
        dockerfile = { hadolint },
        markdown = { markdownlint, prettier_d },
        lua = { stylua },
        terraform = { terraform_fmt },
      }
      opts.filetypes = vim.tbl_keys(languages)
      opts.settings = {
        rootMarkers = { ".git/" },
        languages = languages,
      }
      opts.init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
      }
    end

    lspconfig[server].setup(opts)
  end
end

local M = {}

M.cfg = cfg

return M
