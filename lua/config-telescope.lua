local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

M.cfg = function()
  -- my custom keybindings
  -- vim.api.nvim_set_keymap('n', '<Leader><Space>', '<CMD>Telescope find_files<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<Leader><Space>', '<CMD>lua require\'config-telescope\'.project_files()<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<Leader>b', '<CMD>Telescope buffers show_all_buffers=true<CR>', {noremap = true, silent = true})

  local actions = require('telescope.actions')
  require('telescope').setup {
    defaults = {
      vimgrep_arguments = {'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden'},
      color_devicons = true,
      mappings = {i = {["<CR>"] = actions.select_default + actions.center}}
    }
  }
end

return M
