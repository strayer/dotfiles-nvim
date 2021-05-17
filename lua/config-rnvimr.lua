local M = {}

M.cfg = function()
  local python3 = vim.g.python3_host_prog
  local py3binpath = vim.api.nvim_eval('fnamemodify(g:python3_host_prog, \':h\')')
  vim.g.rnvimr_ranger_cmd = python3 .. ' ' .. py3binpath .. '/ranger --cmd="set draw_borders both"'
end

return M
