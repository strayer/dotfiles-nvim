local lsp_status = require("lsp-status")
lsp_status.register_progress()

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
    silent = true
  }
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

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

  lsp_status.on_attach(client)
end

vim.cmd([[
  command! -nargs=0 LspFormat :lua vim.lsp.buf.formatting()
]])

require("lspkind").init()

vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
]])

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)

-- config that activates keymaps and enables snippet support
local function make_config()
  --[[ local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true ]]
  return {
    -- enable snippet support
    -- capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150
    },
    capabilities = capabilities
  }
end

local diagnosticls_config = {
  filetypes = {
    "dockerfile", "slim"
    -- "lua"
    -- "ruby"
  },
  init_options = {
    filetypes = {
      slim = "slimlint",
      ruby = "rubocop"
    },
    formatFiletypes = {
      lua = "luaformat"
    },
    linters = {
      slimlint = {
        command = "slim-lint",
        sourceName = "slim-lint",
        args = {"-r", "json", "%file"},
        parseJson = {
          errorsRoot = "files.[0].offenses",
          line = "location.line",
          security = "severity",
          message = "${code}: ${message}"
        }
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
        securities = {
          fatal = "error",
          error = "error",
          warning = "warning",
          convention = "info",
          refactor = "info",
          info = "info"
        }
      }
    }
  }
}

-- see efm configuration in $HOME/.config/efm-langserer/config.yaml
local efm_config = {
  init_options = {
    documentFormatting = true
  },
  filetypes = {"lua", "python", "typescript", "vue", "sh", "javascript", "dockerfile"}
}

local function yarn_custom_install_path(install_dir)
  return vim.env.HOME .. "/.config/nvim/lsp-servers/" .. install_dir .. "/node_modules/.bin/"
end

local function server_custom_cmd(server_name)
  if server_name == "bashls" then
    return {yarn_custom_install_path(server_name) .. "bash-language-server", "start"}
  elseif server_name == "diagnosticls" then
    return {yarn_custom_install_path(server_name) .. "diagnostic-languageserver", "--stdio"}
  elseif server_name == "dockerls" then
    return {yarn_custom_install_path(server_name) .. "docker-langserver", "--stdio"}
  elseif server_name == "pyright" then
    return {yarn_custom_install_path(server_name) .. "pyright-langserver", "--stdio"}
  elseif server_name == "tsserver" then
    return {yarn_custom_install_path(server_name) .. "typescript-language-server", "--stdio"}
  elseif server_name == "cssls" then
    return {yarn_custom_install_path("vscode-extracted") .. "vscode-css-language-server", "--stdio"}
  elseif server_name == "html" then
    return {
      yarn_custom_install_path("vscode-extracted") .. "vscode-html-language-server", "--stdio"
    }
  elseif server_name == "yamlls" then
    return {yarn_custom_install_path(server_name) .. "yaml-language-server", "--stdio"}
  elseif server_name == "vuels" then
    return {yarn_custom_install_path(server_name) .. "vls"}
  else
    return nil
  end
end

-- lsp-install
local function setup_servers()
  local tablex = require("pl.tablex")

  local servers = {
    "bashls", "diagnosticls", "dockerls", "sumneko_lua", "pyright", "tsserver", "cssls", "jsonls",
    "html", "vuels", "yamlls", "solargraph", "efm", "terraformls"
  }

  for _, server in ipairs(servers) do
    local config = make_config()
    local custom_cmd = server_custom_cmd(server)

    -- install path overrides
    if custom_cmd then
      config = tablex.merge(config, {
        cmd = custom_cmd
      }, true)
    end

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

    require"lspconfig"[server].setup(config)
  end
end

local M = {}

M.setup_servers = setup_servers

return M
