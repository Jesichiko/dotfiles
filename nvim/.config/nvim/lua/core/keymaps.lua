local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")
local keymap = vim.keymap.set
local lsp = vim.lsp.buf

-- <leader> = " " (space), set in manager -> lazy.lua

-- telescope
keymap("n", "<C-p>", builtin.find_files, opts)
keymap("n", "<leader>fg", builtin.live_grep, opts)
keymap("n", "<C-l>", builtin.oldfiles, opts)

-- neotree
keymap("n", "<C-o>", function()
	vim.cmd("Neotree reveal filesystem right toggle")
end, opts)

-- lsp
keymap("n", "K", lsp.hover, opts)
keymap("n", "gd", lsp.definition, opts)
keymap({ "n", "v" }, "<leader>ca", lsp.code_action, opts)
keymap("n", "<leader>gf", lsp.format, opts)

-- diagnostics
keymap("n", "<leader>e", vim.diagnostic.open_float, opts)
keymap("n", "[d", function()
	vim.diagnostic.jump({ 1, true })
end, opts)
keymap("n", "]d", function()
	vim.diagnostic.jump({ -1, true })
end, opts)
keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)
keymap("n", "<leader>h", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, opts)

-- lazy
keymap("n", "<leader>l", "<cmd>Lazy<CR>", opts)

-- terminal
keymap("n", "<leader>ñ", "<cmd>ToggleTerm<CR>", opts)
