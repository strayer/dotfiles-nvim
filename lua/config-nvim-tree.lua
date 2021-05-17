local M = {}

M.cfg = function()
  vim.api.nvim_set_keymap('n', '<Leader>d', '<CMD>NvimTreeToggle<CR>', {noremap = true, silent = true})

  vim.g.nvim_tree_quit_on_open = 1
  vim.g.nvim_tree_lsp_diagnostics = 1
  vim.g.nvim_tree_disable_netrw = 0
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_auto_close = 1
end

return M
