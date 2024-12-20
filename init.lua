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

require("lazy").setup({
  spec = "plugins",
  install = { missing = false },
})

require("auto-dark-mode").init()

if os.getenv("TMUX") ~= nil then
  vim.cmd([[
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  ]])
end

if vim.g.neovide then
  vim.o.guifont = "Iosevka Term Light,Symbols Nerd Font Mono:h16"
  vim.g.neovide_cursor_vfx_mode = "pixiedust"

  -- vim.g.neovide_window_blurred = true
  -- vim.g.neovide_transparency = 0.9

  -- schedule focusing of Neovide (https://github.com/neovide/neovide/issues/2330)
  vim.schedule(function()
    vim.cmd("NeovideFocus")
  end)

  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set({ "n", "v", "s", "x", "o", "i", "l", "c", "t" }, "<D-v>", function()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end, { noremap = true, silent = true })
end

-- disable fold for slim because it slows everything down
vim.api.nvim_create_autocmd("Syntax", {
  pattern = "slim",
  command = "setlocal nofoldenable",
})

vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
