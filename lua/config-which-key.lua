local M = {}

local keymap = {
  ['?'] = {"<CMD>NvimTreeFindFile<CR>", 'find current file'},
  e = {"<CMD>NvimTreeToggle<CR>", 'explorer'},
  f = {'<CMD>Telescope find_files<CR>', 'files'},
  r = {'<CMD>RnvimrToggle<CR>', 'ranger'},
  h = {'<C-W>s', 'split below'},
  v = {'<C-W>v', 'split right'},
  -- [' '] = {'<CMD>lua require\'config-telescope\'.project_files()<CR>', 'search project files'},
  s = {
    name = '+search',
    b = {'<CMD>Telescope buffers show_all_buffers=true<CR>', 'buffers'},
    B = {'<Cmd>Telescope git_branches<CR>', 'git branches'},
    d = {'<Cmd>Telescope lsp_document_diagnostics<CR>', 'document_diagnostics'},
    D = {'<Cmd>Telescope lsp_workspace_diagnostics<CR>', 'workspace_diagnostics'},
    f = {'<Cmd>Telescope find_files<CR>', 'files'},
    h = {'<Cmd>Telescope command_history<CR>', 'history'},
    i = {'<Cmd>Telescope media_files<CR>', 'media files'},
    m = {'<Cmd>Telescope marks<CR>', 'marks'},
    M = {'<Cmd>Telescope man_pages<CR>', 'man_pages'},
    o = {'<Cmd>Telescope vim_options<CR>', 'vim_options'},
    t = {'<Cmd>Telescope live_grep<CR>', 'text'},
    r = {'<Cmd>Telescope neoclip<CR>', 'registers'},
    w = {'<Cmd>Telescope file_browser<CR>', 'buf_fuz_find'},
    u = {'<Cmd>Telescope colorscheme<CR>', 'colorschemes'}
  },
  l = {
    name = '+lsp',
    a = {'<CMD>Lspsaga code_action<CR>', 'code action'},
    A = {'<CMD>Lspsaga range_code_action<CR>', 'selected action'},
    d = {'<CMD>Telescope lsp_document_diagnostics<CR>', 'document diagnostics'},
    D = {'<CMD>Telescope lsp_workspace_diagnostics<CR>', 'workspace diagnostics'},
    f = {'<CMD>LspFormat<CR>', 'format'},
    I = {'<CMD>LspInfo<CR>', 'lsp info'},
    v = {'<CMD>LspVirtualTextToggle<CR>', 'lsp toggle virtual text'},
    l = {'<CMD>Lspsaga lsp_finder<CR>', 'lsp finder'},
    L = {'<CMD>Lspsaga show_line_diagnostics<CR>', 'line_diagnostics'},
    p = {'<CMD>Lspsaga preview_definition<CR>', 'preview definition'},
    q = {'<CMD>Telescope quickfix<CR>', 'quickfix'},
    r = {'<CMD>Lspsaga rename<CR>', 'rename'},
    T = {'<CMD>LspTypeDefinition<CR>', 'type defintion'},
    x = {'<CMD>cclose<CR>', 'close quickfix'},
    s = {'<CMD>Telescope lsp_document_symbols<CR>', 'document symbols'},
    S = {'<CMD>Telescope lsp_workspace_symbols<CR>', 'workspace symbols'}
  },
  w = {
    name = '+window',
    q = {'<C-W>q', 'close'},
    o = {'<C-W>o', 'other'},
    h = {'<C-W>h', 'left'},
    j = {'<C-W>j', 'down'},
    k = {'<C-W>k', 'up'},
    l = {'<C-W>l', 'right'},
  },
  t = {
    name = '+terminal',
    f = {'<CMD>FloatermToggle<CR>', 'floating'},
    v = {'<CMD>bo vsplit term://$SHELL<CR>'},
    h = {'<CMD>bo split term://$SHELL<CR>'}
  }
}

M.cfg = function()
  local wk = require('whichkey_setup')

  vim.api.nvim_set_keymap('n', '<leader>', '<CMD>WhichKey "<Space>"<CR>', {noremap = true, silent = true})
  wk.register_keymap('leader', keymap)
end

return M
