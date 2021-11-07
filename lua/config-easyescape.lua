local M = {}

M.cfg = function()
  vim.g.easyescape_chars = { j = 1, k = 1 }
  vim.g.easyescape_timeout = 100
  vim.cmd([[
    cnoremap jk <ESC>
    cnoremap kj <ESC>
  ]])
end

return M
