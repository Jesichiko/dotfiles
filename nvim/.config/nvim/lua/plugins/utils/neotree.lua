return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},

	lazy = false,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,

			git_status = {
				symbols = {
					added = " ",
					untracked = " ",
					staged = " ",
				},
			},

			window = {
				position = "right",
				mappings = {
					["p"] = "toggle_preview",
					["l"] = "focus_preview",
					["s"] = "open_vsplit",
					["r"] = "refresh",
				},
			},

			filesystem = {
				--use_libuv_file_watcher = true
				group_empty_dirs = true,
				filtered_items = {
					hide_by_pattern = { "*.class", "*.pyc" },
					always_show_by_pattern = { ".env*" },
				},
			},
		})
	end,
}
