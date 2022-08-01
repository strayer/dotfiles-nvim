local M = {}

M.cfg = function()
  require("lualine").setup({
    options = { theme = "auto" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "diff", { "diagnostics", sources = { "nvim_diagnostic" } }, "filename", "lsp_progress" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    extensions = { "fugitive", "nvim-tree" },
  })
end

return M
