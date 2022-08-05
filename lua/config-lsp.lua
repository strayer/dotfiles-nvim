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

  -- setup lightbulb
  vim.cmd([[
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
  ]])

  -- setup cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  require("mason").setup()
  require("mason-lspconfig").setup()
  local lspconfig = require("lspconfig")

  local lsp_servers = {
    "ansiblels",
    "bashls",
    "dockerls",
    "eslint",
    "emmet_ls",
    "pyright",
    "sumneko_lua",
    "terraformls",
    "tsserver",
    "vuels",
    -- "volar",
    "yamlls",
    "solargraph",
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

    if server == "sumneko_lua" then
      opts.settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            enable = true,
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
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

    if server == "yamlls" then
      opts.settings = {
        redhat = {
          telemetry = {
            enabled = false,
          },
        },
        yaml = {
          schemas = {
            ["https://github.com/compose-spec/compose-spec/raw/master/schema/compose-spec.json"] = {
              "compose.yaml",
              "compose.yml",
              "docker-compose.yaml",
              "docker-compose.yml",
            },
          },
        },
      }
    end

    lspconfig[server].setup(opts)
  end

  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.hadolint.with({ filetypes = { "Dockerfile", "dockerfile" } }),
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.diagnostics.markdownlint.with({
        dynamic_command = require("null-ls.helpers.command_resolver").from_node_modules,
      }),
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd,
      -- null_ls.builtins.diagnostics.rubocop.with({
      --   command = "bundle",
      --   args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
      -- }),
      -- null_ls.builtins.formatting.rubocop.with({
      --   command = "bundle",
      --   args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
      -- }),
    },
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  })
end

local M = {}

M.cfg = cfg

return M
