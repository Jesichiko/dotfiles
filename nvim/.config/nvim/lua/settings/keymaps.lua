-- @Keymaps

local opts = { noremap = true, silent = true }

-- <leader> = "<space>" -> lazy.lua

-- @Search:
-- Telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, opts)
vim.keymap.set("n", "<C-o>", builtin.oldfiles, opts)
vim.keymap.set("n", "<C-l>", builtin.live_grep, opts)

-- Oil
vim.keymap.set("n", "<C-ñ>", "<cmd>Oil<CR>", opts)

-- @Langs:
-- @LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "<leader>gf", function()
	require("conform").format({ lsp_format = "fallback" })
end, opts)

-- @LSP Manager
vim.keymap.set("n", "<C-k>", "<cmd>Mason<CR>", opts)

-- @Diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "<leader>h", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, opts)

-- @Plugin Manager:
-- @Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", opts)
