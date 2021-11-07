local M = {}

local keymap = {
  ["?"] = { "<CMD>NvimTreeFindFile<CR>", "find current file" },
  e = { "<CMD>NvimTreeToggle<CR>", "explorer" },
  f = { "<CMD>Telescope find_files<CR>", "files" },
  r = { "<CMD>RnvimrToggle<CR>", "ranger" },
  h = { "<C-W>s", "split below" },
  v = { "<C-W>v", "split right" },
  -- [' '] = {'<CMD>lua require\'config-telescope\'.project_files()<CR>', 'search project files'},
  d = {
    name = "+debug",
    b = { '<CMD>lua require"dap".toggle_breakpoint()<CR>', "toggle breakpoint" },
    c = { '<CMD>lua require"dap".continue()<CR>', "continue" },
    o = { '<CMD>lua require"dap".step_over()<CR>', "step over" },
    i = { '<CMD>lua require"dap".step_into()<CR>', "step into" },
    r = { '<CMD>lua require"dap".repl.open()<CR>', "repl" },
  },
  s = {
    name = "+search",
    b = { "<CMD>Telescope buffers show_all_buffers=true<CR>", "buffers" },
    B = { "<Cmd>Telescope git_branches<CR>", "git branches" },
    d = { "<Cmd>Telescope lsp_document_diagnostics<CR>", "document_diagnostics" },
    D = { "<Cmd>Telescope lsp_workspace_diagnostics<CR>", "workspace_diagnostics" },
    f = { "<Cmd>Telescope find_files<CR>", "files" },
    h = { "<Cmd>Telescope command_history<CR>", "history" },
    i = { "<Cmd>Telescope media_files<CR>", "media files" },
    m = { "<Cmd>Telescope marks<CR>", "marks" },
    M = { "<Cmd>Telescope man_pages<CR>", "man_pages" },
    o = { "<Cmd>Telescope vim_options<CR>", "vim_options" },
    t = { "<Cmd>Telescope live_grep<CR>", "text" },
    r = { "<Cmd>Telescope neoclip<CR>", "registers" },
    w = { "<Cmd>Telescope file_browser<CR>", "buf_fuz_find" },
    u = { "<Cmd>Telescope colorscheme<CR>", "colorschemes" },
  },
  l = {
    name = "+lsp",
    d = { "<CMD>Telescope lsp_document_diagnostics<CR>", "document diagnostics" },
    D = { "<CMD>Telescope lsp_workspace_diagnostics<CR>", "workspace diagnostics" },
    f = { "<CMD>LspFormat<CR>", "format" },
    I = { "<CMD>LspInfo<CR>", "lsp info" },
    v = { "<CMD>LspVirtualTextToggle<CR>", "lsp toggle virtual text" },
    q = { "<CMD>Telescope quickfix<CR>", "quickfix" },
    t = { "<CMD>Trouble<CR>", "trouble" },
    T = { "<CMD>LspTypeDefinition<CR>", "type defintion" },
    x = { "<CMD>cclose<CR>", "close quickfix" },
    s = { "<CMD>Telescope lsp_document_symbols<CR>", "document symbols" },
    S = { "<CMD>Telescope lsp_workspace_symbols<CR>", "workspace symbols" },
    r = { "<CMD>Lspsaga rename<cr>", "rename symbol" },
  },
  w = {
    name = "+window",
    q = { "<C-W>q", "close" },
    o = { "<C-W>o", "other" },
    h = { "<C-W>h", "left" },
    j = { "<C-W>j", "down" },
    k = { "<C-W>k", "up" },
    l = { "<C-W>l", "right" },
  },
  t = {
    name = "+terminal",
    f = { "<CMD>FloatermToggle<CR>", "floating" },
    v = { "<CMD>bo vsplit term://$SHELL<CR>" },
    h = { "<CMD>bo split term://$SHELL<CR>" },
  },
}

M.cfg = function()
  local wk = require("whichkey_setup")

  vim.api.nvim_set_keymap("n", "<leader>", '<CMD>WhichKey "<Space>"<CR>', { noremap = true, silent = true })
  wk.register_keymap("leader", keymap)
end

return M
