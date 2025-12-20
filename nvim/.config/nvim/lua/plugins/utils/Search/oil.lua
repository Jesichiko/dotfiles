return {
	"stevearc/oil.nvim",

	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,

		view_options = {
			show_hidden = true,

			is_always_hidden = function(name, bufnr)
				return name:match("%.(pyc|class)$")
			end,
		},
	},
	lazy = false,
}
