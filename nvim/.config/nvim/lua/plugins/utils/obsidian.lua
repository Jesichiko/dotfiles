return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/vaults/personal",
            },
            {
                name = "work",
                path = "~/vaults/work",
            },
        },

        -- see below for full list of options 👇
    },
}
