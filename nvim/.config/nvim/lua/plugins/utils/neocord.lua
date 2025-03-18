return {
  "IogaMaster/neocord",
  event = "VeryLazy",
  config = function()
    local f = io.popen("fortune")
    local fortune_text

    if f == nil then
      fortune_text = "Do you remember?"
    else
      fortune_text = f:read("*a")
      f:close()
    end

    require("neocord").setup({
      logo_tooltip = fortune_text
    })
  end,
}
