local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

M.cfg = function()
  vim.api.nvim_set_keymap('n', '<Leader><Space>', '<CMD>lua require\'config-telescope\'.project_files()<CR>', {noremap = true, silent = true})

  local actions = require('telescope.actions')
  require('telescope').setup {
    extensions = {fzf = {fuzzy = true, override_generic_sorter = false, override_file_sorter = true, case_mode = "smart_case"}},
    defaults = {
      vimgrep_arguments = {'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden'},
      color_devicons = true,
      mappings = {i = {["<CR>"] = actions.select_default + actions.center}}
    }
  }
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('neoclip')
end

return M
