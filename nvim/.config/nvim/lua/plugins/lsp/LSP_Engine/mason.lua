return {
	"mason-org/mason.nvim",
	opts = { automatic_installation = true },

	dependencies = {
		{ "mason-org/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	},
}
