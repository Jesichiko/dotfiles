-- @VIM.O Options

-- indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- relative number
vim.o.number = true
vim.o.relativenumber = true

-- split
vim.opt.splitbelow = true
vim.o.splitright = true

-- wrap
vim.o.wrap = false

-- clipboard
vim.o.clipboard = "unnamedplus"

-- scrolling
vim.o.scrolloff = 999

-- v-block
vim.o.virtualedit = "block"

-- replace split
vim.o.inccommand = "split"

-- cmdline
vim.o.ignorecase = true
vim.o.signcolumn = "yes"

-- colorscheme
vim.cmd.colorscheme("oldworld")
