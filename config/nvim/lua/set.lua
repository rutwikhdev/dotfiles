vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = ". " }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.opt.tabstop = 4 -- how many spaces a tab character looks like
vim.opt.shiftwidth = 4 -- how many spaces >> and << indent by
vim.opt.expandtab = true -- insert spaces instead of a real tab character
vim.opt.shiftround = true -- round indents to nearest shiftwidth multiple

vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
