vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

require("config.lazy")
require("keybinds")
vim.cmd("colorscheme carbonfox")
