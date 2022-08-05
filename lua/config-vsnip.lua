local M = {}

M.cfg = function()
  vim.g.vsnip_snippet_dir = os.getenv("HOME") .. "/.config/nvim/vsnip"
  vim.g.vsnip_filetypes = { ruby = {'rails'} }
end

return M
