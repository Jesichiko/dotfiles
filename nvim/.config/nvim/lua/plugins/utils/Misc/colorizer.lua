return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({
			"*",
			"TelescopePrompt",
			"!alpha",
			"!lazy",
			"!Outline",
			css = { rgb_fn = true },
			html = { names = false },
		})
	end,
}
