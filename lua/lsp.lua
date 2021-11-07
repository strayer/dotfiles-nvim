local lsp_status = require("lsp-status")

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

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end

  lsp_status.on_attach(client)
end

local function cfg()
  -- setup lsp-status
  lsp_status.register_progress()

  vim.cmd([[
    command! -nargs=0 LspFormat :lua vim.lsp.buf.formatting()
  ]])

  -- setup lspkind
  require("lspkind").init()

  -- setup lightbulb
  vim.cmd([[
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
  ]])

  -- setup cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)

  -- setup lsp-installer
  local lsp_installer = require("nvim-lsp-installer")

  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
      capabilities = capabilities,
    }

    if server.name == "tsserver" then
      opts.on_attach = function(client)
        on_attach(client)

        -- formatting handled by prettier
        client.resolved_capabilities.document_formatting = false
      end
    end

    if server.name == "solargraph" then
      opts.init_options = {
        formatting = false,
      }
      opts.settings = {
        solargraph = {
          diagnostics = false,
          formatting = false,
        },
      }
    end

    if server.name == "sumneko_lua" then
      opts.settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
            maxPreload = 10000,
          },
        },
      }
    end

    server:setup(opts)
    vim.cmd([[ do User LspAttachBuffers ]])
  end)

  local null_ls = require("null-ls")
  null_ls.config({
    sources = {
      null_ls.builtins.diagnostics.hadolint.with({ filetypes = { "Dockerfile", "dockerfile" } }),
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier_d_slim,
      null_ls.builtins.diagnostics.rubocop.with({
        command = "bundle",
        args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
      }),
      null_ls.builtins.formatting.rubocop.with({
        command = "bundle",
        args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
      }),
    },
  })
  require("lspconfig")["null-ls"].setup({
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
