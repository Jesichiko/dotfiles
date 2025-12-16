local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")
local keymap = vim.keymap.set
local lsp = vim.lsp.buf
local cmd = vim.cmd

-- <leader> = " " (space), set in manager -> lazy.lua

-- Telescope @search
keymap("n", "<C-p>", builtin.find_files, opts)
keymap("n", "<leader>fg", builtin.live_grep, opts)
keymap("n", "<C-l>", builtin.oldfiles, opts)

-- Neotree @filesystem
keymap("n", "<C-o>", function()
	vim.cmd("Neotree reveal filesystem left toggle")
end, opts)

-- LSP @langs
keymap("n", "K", lsp.hover, opts)
keymap("n", "gd", lsp.definition, opts)
keymap({ "n", "v" }, "<leader>ca", lsp.code_action, opts)
keymap("n", "<leader>gf", lsp.format, opts)

-- Diagnostics
keymap("n", "<leader>e", vim.diagnostic.open_float, opts)
keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)
keymap("n", "<leader>h", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, opts)

-- Lazy
keymap("n", "<leader>l", "<cmd>Lazy<CR>", opts)

-- Terminal
keymap("n", "<leader>ñ", "<cmd>ToggleTerm<CR>", opts)
