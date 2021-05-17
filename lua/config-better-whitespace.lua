local M = {}

M.add_dashboard_to_blacklist = function()
  local better_whitespace_filetypes_blacklist = vim.g.better_whitespace_filetypes_blacklist
  table.insert(better_whitespace_filetypes_blacklist, 'dashboard')
  vim.g.better_whitespace_filetypes_blacklist = better_whitespace_filetypes_blacklist
end

M.cfg = function()
  vim.cmd [[ autocmd! FileType dashboard lua require("config-better-whitespace").add_dashboard_to_blacklist() ]]
end

return M
