local M = {}

M.cfg = function()
  local lsp_status = require'lsp-status'

  THEME = require('theme')
  require('lualine').setup({
    options = {theme = THEME.active_theme},
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {'diff', {'diagnostics', sources = {'nvim_lsp'}}, 'filename'},
      lualine_x = {lsp_status.status, 'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    extensions = {'fugitive', 'nvim-tree'}
  })
end

return M
