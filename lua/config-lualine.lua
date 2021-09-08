local M = {}

M.cfg = function()
  THEME = require('theme')
  require('lualine').setup({options = {theme = THEME.active_theme}})
end

return M
