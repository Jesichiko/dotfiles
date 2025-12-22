return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	opts = {
		render_modes = { "n", "c", "t" },
		completions = { lsp = { enabled = true } },
		latex = {
			enabled = true,
			render_modes = false,
			converter = "utftex",
			highlight = "RenderMarkdownMath",
			position = "center",
			top_pad = 0,
			bottom_pad = 0,
		},
	},
}
