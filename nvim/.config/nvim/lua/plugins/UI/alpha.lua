return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local header = require("art-dashboard.art")

    -- Header
    dashboard.section.header = header

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
    local f = io.popen("fortune")
    local fortune_text

    if f == nil then
      fortune_text = "Despite everything, it's still you..."
    else
      fortune_text = f:read("*a")
      f:close()
    end
    dashboard.section.footer.val = fortune_text
    alpha.setup(dashboard.config)
  end,
}
