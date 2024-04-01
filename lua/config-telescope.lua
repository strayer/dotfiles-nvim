local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

M.cfg = function()
  local actions = require("telescope.actions")
  require("telescope").setup({
    extensions = {
      fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
    },
    defaults = {
      color_devicons = true,
      mappings = { i = { ["<CR>"] = actions.select_default + actions.center } },
    },
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
      },
      grep_string = {
        additional_args = { '--hidden' }
      },
      live_grep = {
        additional_args = { '--hidden' }
      }
    }
  })
  require("telescope").load_extension("fzf")
end

return M
