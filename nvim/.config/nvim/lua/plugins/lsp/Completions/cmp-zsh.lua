return {
    "tamago324/cmp-zsh",
    config = function()
        require("cmp_zsh").setup({
        filetypes = { "deoledit", "zsh" }
        })
    end
}
