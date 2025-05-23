return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	opts = {
		workspaces = {
			{
				name = "BUAP Notes",
				path = "~/Documentos/Obsidian Vault",
			},
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
	},
}
