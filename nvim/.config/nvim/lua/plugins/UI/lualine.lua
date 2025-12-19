return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.icons",
	},

	config = function()
		local custom_catppuccin = require("lualine.themes.catppuccin")

		-- Custom colours
		custom_catppuccin.normal.b.fg = "#cad3f5"
		custom_catppuccin.insert.b.fg = "#cad3f5"
		custom_catppuccin.visual.b.fg = "#cad3f5"
		custom_catppuccin.replace.b.fg = "#cad3f5"
		custom_catppuccin.command.b.fg = "#cad3f5"
		custom_catppuccin.inactive.b.fg = "#cad3f5"
		custom_catppuccin.normal.c.fg = "#6e738d"
		custom_catppuccin.normal.c.bg = "#1e2030"

		require("lualine").setup({

			-- general_options
			options = {
				theme = custom_catppuccin,
				section_separators = { left = "", right = "" },
				component_separators = { left = "::", right = "::" },
				disabled_filetypes = { "alpha", "Outline" },
			},

			sections = {

				-- vim mode
				lualine_a = {
					{ "mode" },
				},

				-- file
				lualine_b = {
					{
						"filetype",
						icon_only = true,
						padding = { left = 1, right = 0 },
					},
					"filename",
				},

				-- diagnostics and git branch
				lualine_x = {
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						update_in_insert = true,
					},
					{
						"branch",
						icon = "",
					},
				},

				-- datetime
				lualine_z = {
					function()
						return os.date("%I:%M%p")
					end,
				},

				lualine_c = {},
				lualine_y = {},
			},

			inactive_sections = {
				lualine_c = {},
				lualine_y = {},
			},

			extensions = { "mason", "lazy" },
		})
	end,
}
