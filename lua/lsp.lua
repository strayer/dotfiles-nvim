local nvim_lsp = require('lspconfig')
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
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
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

-- Servers

-- TODO:
-- coc-tsserver
-- coc-eslint
-- coc-prettier
-- coc-go

nvim_lsp.bashls.setup {on_attach = on_attach}
nvim_lsp.dockerls.setup {on_attach = on_attach}
nvim_lsp.pyright.setup {on_attach = on_attach}
nvim_lsp.diagnosticls.setup {
  filetypes = {
    "sh", "dockerfile", "slim", "lua"
    -- "ruby"
  },
  init_options = {
    filetypes = {sh = "shellcheck", dockerfile = "hadolint", slim = "slimlint", ruby = "rubocop"},
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
  },
  on_attach = on_attach
}
nvim_lsp.solargraph.setup {init_options = {solargraph = {diagnostics = true}}, flags = {debounce_text_changes = 150}, on_attach = on_attach}
nvim_lsp.cssls.setup {on_attach = on_attach}
nvim_lsp.yamlls.setup {on_attach = on_attach}
nvim_lsp.jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
      end
    }
  },
  on_attach = on_attach
}
nvim_lsp.vimls.setup {on_attach = on_attach}
nvim_lsp.efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {"lua", "python"},
  settings = {
    rootMarkers = {".git/", "nvim/"},
    languages = {
      python = {
        {formatCommand = "black --quiet -", formatStdin = true},
        {lintCommand = "flake8 --stdin-display-name ${INPUT} -", lintStdin = true, lintFormats = {'%f:%l:%c: %m'}}
      },
      lua = {
        {
          formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
          formatStdin = true
        }
      }
    }
  },
  on_attach = on_attach
}
nvim_lsp.terraformls.setup {on_attach = on_attach}
