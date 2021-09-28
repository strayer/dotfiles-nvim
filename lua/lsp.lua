local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = {noremap = true, silent = true}
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

vim.cmd([[
  command! -nargs=0 LspFormat :lua vim.lsp.buf.formatting()
]])

require('lspkind').init()

vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
]])

-- config that activates keymaps and enables snippet support
local function make_config()
  --[[ local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true ]]
  return {
    -- enable snippet support
    -- capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

local diagnosticls_config = {
  filetypes = {
    "dockerfile", "slim"
    -- "lua"
    -- "ruby"
  },
  init_options = {
    filetypes = {dockerfile = "hadolint", slim = "slimlint", ruby = "rubocop"},
    formatFiletypes = {lua = "luaformat"},
    linters = {
      hadolint = {
        command = "hadolint",
        sourceName = "hadolint",
        args = {"-f", "json", "-"},
        parseJson = {line = "line", colume = "column", security = "level", message = "${message} [${code}]"},
        securities = {error = "error", warning = "warning", info = "info", style = "hint"}
      },
      slimlint = {
        command = "slim-lint",
        sourceName = "slim-lint",
        args = {"-r", "json", "%file"},
        parseJson = {errorsRoot = "files.[0].offenses", line = "location.line", security = "severity", message = "${code}: ${message}"}
      },
      rubocop = {
        command = "bundle",
        sourceName = "rubocop",
        debounce = 10,
        args = {"exec", "rubocop", "--format", "json", "--force-exclusion", "--stdin", "%filepath"},
        parseJson = {
          errorsRoot = "files[0].offenses",
          line = "location.start_line",
          endLine = "location.last_line",
          column = "location.start_column",
          endColumn = "location.end_column",
          message = "[${cop_name}] ${message}",
          security = "severity"
        },
        securities = {fatal = "error", error = "error", warning = "warning", convention = "info", refactor = "info", info = "info"}
      }
    },
    formatters = {
      luaformat = {
        command = "lua-format",
        args = {
          "-i", "--no-keep-simple-function-one-line", "--no-break-after-operator", "--column-limit=150", "--break-after-table-lb", "--no-use-tab",
          "--indent-width=2"
        }
      }
    }
  }
}

local efm_config = {
  init_options = {documentFormatting = true},
  filetypes = {"lua", "python", "typescript", "vue", "sh", "javascript"},
  settings = {
    rootMarkers = {".git/", "nvim/", "package.json"},
    languages = {
      sh = {
        {
          lintCommand = "shellcheck -f gcc -x",
          lintSource = "shellcheck",
          lintFormats = {"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"}
        }
      },
      python = {
        {formatCommand = "black --quiet -", formatStdin = true},
        {lintCommand = "flake8 --stdin-display-name ${INPUT} -", lintStdin = true, lintFormats = {'%f:%l:%c: %m'}}
      },
      lua = {
        {
          formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb --no-use-tab --indent-width=2",
          formatStdin = true
        }
      },
      typescript = {
        {
          formatCommand = "prettier_d_slim --stdin --stdin-filepath ${INPUT}",
          formatStdin = true,
          lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
          lintIgnoreExitCode = true,
          lintStdin = true,
          lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"}
        }
      },
      javascript = {
        {
          formatCommand = "prettier_d_slim --stdin --stdin-filepath ${INPUT}",
          formatStdin = true,
          lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
          lintIgnoreExitCode = true,
          lintStdin = true,
          lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"}
        }
      },
      vue = {
        {
          formatCommand = "prettier_d_slim --stdin --stdin-filepath ${INPUT}",
          formatStdin = true,
          lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
          lintIgnoreExitCode = true,
          lintStdin = true,
          lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"}
        }
      }
    }
  }
}

-- lsp-install
local function setup_servers()
  local tablex = require('pl.tablex')

  require'lspinstall'.setup()

  -- get all installed servers
  local servers = require'lspinstall'.installed_servers()
  -- ... and add manually installed servers
  table.insert(servers, "solargraph")
  table.insert(servers, "efm")
  table.insert(servers, "terraformls")

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "diagnosticls" then config = tablex.merge(config, diagnosticls_config, true) end
    if server == "efm" then config = tablex.merge(config, efm_config, true) end
    if server == "typescript" then
      config.on_attach = function(client)
        on_attach(client)

        -- formatting handled by prettier
        client.resolved_capabilities.document_formatting = false
      end
    end

    require'lspconfig'[server].setup(config)
  end
end

local M = {}

M.setup_servers = setup_servers

return M
