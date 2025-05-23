local opt = vim.opt

-- indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- relative number
opt.number = true
opt.relativenumber = true

-- split
opt.splitright = true

-- wrap
opt.wrap = false

-- clipboard
opt.clipboard = "unnamedplus"

-- scrolling
opt.scrolloff = 999

opt.virtualedit = "block"

-- replace split
opt.inccommand = "split"

opt.ignorecase = true
opt.signcolumn = "yes"

-- colorscheme
vim.cmd("colorscheme catppuccin-macchiato")

