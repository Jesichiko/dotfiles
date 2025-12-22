return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local header = require("plugins.UI.art-dashboard.art")
		local fortune = require("alpha.fortune")

		-- Header
		dashboard.config.layout[2] = header

		-- Tasks
		dashboard.section.tasks = {
			type = "text",
			val = os.date("%I:%M %p, %d - %b"),
			opts = {
				hl = "Keyword",
				position = "center",
			},
		}

		-- Center
		dashboard.section.buttons.val = {
			dashboard.button("n", "  Nuevo Archivo", ":ene<CR>"),
			dashboard.button("r", "  Recientes", ":Telescope oldfiles<CR>"),
			dashboard.button("a", "  Buscar Archivo", ":Telescope find_files<CR>"),
			dashboard.button("t", "  Buscar Texto", ":Telescope live_grep<CR>"),
			dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
			dashboard.button("q", "  Salir", ":qa<CR>"),
		}

		-- Footer
		dashboard.section.footer.val = fortune()

		-- Layout
		dashboard.config.layout = {
			{ type = "padding", val = 0 },
			header,
			{ type = "padding", val = 1 },
			dashboard.section.tasks,
			{ type = "padding", val = 0 },
			{
				type = "group",
				val = {
					{
						type = "group",
						val = dashboard.section.buttons.val,
						opts = { spacing = 1 },
					},
				},
				opts = {
					layout = "horizontal",
				},
			},
			{ type = "padding", val = 0 },
			dashboard.section.footer,
		}

		alpha.setup(dashboard.config)
	end,
}
