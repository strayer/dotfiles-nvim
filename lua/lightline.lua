local helpers = require'helpers'

function _G.LightlineFiletype()
  local filetype = vim.bo.filetype

  if filetype == "" then
    return 'no ft'
  else
    return helpers.Trim(filetype .. ' ' .. vim.fn["nerdfont#find"]())
  end
end

vim.api.nvim_exec(
[[
function! LightlineFiletype()
  return v:lua.LightlineFiletype()
endfunction
]],
false)

vim.g.lightline = {
  colorscheme = vim.g.colors_name,
  active = {
    left = { { 'mode', 'paste' }, { 'coc_errors', 'coc_warnings', 'coc_ok' }, { 'gitbranch', 'readonly', 'filename', 'modified' }, { 'coc_status' } }
  },
  component_function = {
    gitbranch = 'gitbranch#name',
    filetype = 'LightlineFiletype',
  }
}
