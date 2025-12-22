return {
	"3rd/image.nvim",
	build = false,
	ft = { "markdown", "norg", "vimwiki" },
	cmd = { "ImagePreview" },
	opts = {
		processor = "magick_cli",
	},
}
