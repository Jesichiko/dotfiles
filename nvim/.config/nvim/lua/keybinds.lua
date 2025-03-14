--telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

--neotree
vim.keymap.set("n", "<C-o>", function()
	vim.cmd("Neotree reveal filesystem right toggle")
end, {})

--lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

--lazy keybinds
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", {})

--terminal
vim.keymap.set("n", "<leader>ñ", "<cmd>term<CR>", {})
