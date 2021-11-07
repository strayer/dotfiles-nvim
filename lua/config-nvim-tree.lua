local M = {}

M.cfg = function()
  vim.g.nvim_tree_quit_on_open = 1
  vim.g.nvim_tree_indent_markers = 1

  require("nvim-tree").setup({
    diagnostics = {
      enable = true,
    },
    disable_netrw = false,
    auto_close = true,
    update_focused_file = {
      enable = true,
    },
  })

  require("nvim-tree.view").View.winopts.relativenumber = true
end

return M
