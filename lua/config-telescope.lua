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
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      color_devicons = true,
      mappings = { i = { ["<CR>"] = actions.select_default + actions.center } },
    },
  })
  require("telescope").load_extension("fzf")
end

return M
