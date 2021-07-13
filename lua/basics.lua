vim.o.termguicolors = true
vim.g.termguicolors = true

vim.o.lazyredraw = true
vim.o.showmatch = true
vim.o.number = true
vim.wo.number = true
vim.o.cursorline = true
vim.wo.cursorline = true
vim.o.relativenumber = true
vim.wo.relativenumber = true

-- show diagnostic messages faster
vim.o.updatetime = 300

vim.g.incsearch = true -- search as characters are entered
vim.g.hlsearch = true -- highlight matches

-- configure leader to space
vim.g.mapleader = " "

-- mouse mode
vim.o.mouse = 'a'

-- indentation
-- doing this with vimscript for now until I figure out vim.g/o/bo
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
vim.o.softtabstop = 0
vim.bo.softtabstop = 0
vim.o.expandtab = true
vim.bo.expandtab = true

-- avoid syntax highlighting for very long lines
vim.o.synmaxcol = 600
vim.bo.synmaxcol = 600

-- enable undofile
vim.o.undofile = true
vim.bo.undofile = true

-- theme
-- vim.o.background = "dark"
-- vim.cmd "colorscheme nightfly"

-- vim.o.background = "light"
-- vim.cmd "colorscheme edge"

vim.o.background = "dark"
vim.cmd "colorscheme tokyonight"

-- vim.o.background = "light"
-- vim.cmd "colorscheme tokyonight"

-- require('github-theme').setup({themeStyle = 'light'})

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
