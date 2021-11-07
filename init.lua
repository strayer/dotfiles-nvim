require("impatient")
require("basics")
require("plugins")
require("packer_compiled")

if os.getenv("TMUX") ~= nil then
  vim.cmd([[
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  ]])
end

-- disable fold for slim because it slows everything down
vim.cmd([[autocmd Syntax slim setlocal nofoldenable]])

vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
