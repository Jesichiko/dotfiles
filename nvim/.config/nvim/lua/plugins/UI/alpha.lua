return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local header = require("plugins.UI.art-dashboard.art")

    -- Header
    dashboard.config.layout[2] = header

    -- Center
    dashboard.section.buttons.val = {
      dashboard.button("n", "  Nuevo Archivo", ":ene<CR>"),
      dashboard.button("r", "  Recientes", ":Telescope oldfiles<CR>"),
      dashboard.button("a", "  Buscar Archivo", ":Telescope find_files<CR>"),
      dashboard.button("t", "  Buscar Texto", ":Telescope live_grep<CR>"),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("q", "  Salir", ":qa<CR>")
    }

    -- Footer
    local f = io.popen("fortune linux")
    local fortune_text

    if f == nil then
      fortune_text = "Despite everything, it's still you..."
    else
      fortune_text = f:read("*a")
      f:close()
    end
    dashboard.section.footer.val = fortune_text

    -- Layout
    dashboard.config.layout = {
      { type = "padding", val = 3 },
      header,
      { type = "padding", val = 2 },
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
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.config)
  end,
}
