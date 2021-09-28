M = {}

M.active_theme = 'tokyonight';
-- M.active_theme = 'github';

M.cfg_theme = function()
  if M.active_theme == 'tokyonight' then
    vim.o.background = "dark"
    vim.cmd [[colorscheme tokyonight]]
  end

  if M.active_theme == 'github' then
    vim.o.background = "light"
    require("github-theme").setup({theme_style = "light_default"})
  end
end

return M
