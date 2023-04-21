local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("basics")

require("lazy").setup("plugins")

if vim.env.TERMINAL_THEME == "light" then
  vim.cmd([[ colorscheme github_light ]])
else
  -- vim.cmd([[ colorscheme tokyonight ]])
  vim.cmd([[ colorscheme tokyonight-storm ]])
  -- vim.cmd([[ colorscheme tokyonight-day ]])
end

-- old packer stuff
-- require("plugins")
-- require("packer_compiled")

if os.getenv("TMUX") ~= nil then
  vim.cmd([[
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  ]])
end

-- disable fold for slim because it slows everything down
vim.cmd([[autocmd Syntax slim setlocal nofoldenable]])

vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
