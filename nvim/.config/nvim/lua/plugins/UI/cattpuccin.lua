return {
  "catppuccin/nvim",
  name = "catpuccin",
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      integrations = {
        cmp = true,
        nvimtree = true,
        treesitter = true,
        gitsigns = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      }
    })
  end,
}
