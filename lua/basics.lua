vim.opt.termguicolors = true

vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true

-- show diagnostic messages faster
vim.opt.updatetime = 300

vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = true -- highlight matches

-- configure leader to space
vim.g.mapleader = " "

-- mouse mode
vim.opt.mouse = "a"

-- indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0
vim.opt.expandtab = true

-- avoid syntax highlighting for very long lines
vim.opt.synmaxcol = 600

-- enable undofile
vim.opt.undofile = true

--  https://stackoverflow.com/a/61382706/360593
--  vim highlights $() in sh files as an error, because the original sh does not
--  support it. POSIX does support it and pretty much everything I use is POSIX
--  compliant, so just tell vim to be POSIX compliant too.
--  2021-02-06: this seems to be irrelevant because /bin/sh is bash on macOS and
--              neovim apparently figures this out itself.
vim.g.is_posix = 1

-- disable Python 2 provider
vim.g.loaded_python_provider = 0
-- use venv for Python 3 provider
vim.g.python3_host_prog = "~/.config/nvim/python3-venv/bin/python"
-- disable Perl provider
vim.g.loaded_perl_provider = 0

vim.cmd([[
  autocmd TermOpen * startinsert
]])

vim.cmd([[
  autocmd FileType gitcommit setlocal spell
]])

