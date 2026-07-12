local function map(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
end

map("<leader>h", "<C-W>s", "split below")
map("<leader>v", "<C-W>v", "split right")

map("<leader>lI", "<CMD>LspInfo<CR>", "lsp info")
map("<leader>lT", vim.lsp.buf.type_definition, "type definition")
map("<leader>lx", "<CMD>cclose<CR>", "close quickfix")
map("<leader>lr", vim.lsp.buf.rename, "rename symbol")
map("<leader>lK", vim.lsp.buf.hover, "hover doc")

map("<leader>th", "<CMD>bo split term://$SHELL<CR>", "horizontal split terminal")
map("<leader>tv", "<CMD>bo vsplit term://$SHELL<CR>", "vertical split terminal")

map("<leader>wq", "<C-W>q", "close")
map("<leader>wo", "<C-W>o", "other")
map("<leader>wh", "<C-W>h", "left")
map("<leader>wj", "<C-W>j", "down")
map("<leader>wk", "<C-W>k", "up")
map("<leader>wl", "<C-W>l", "right")
