return {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = "VeryLazy",
    config = function()
        -- Tooltip
        local f = io.popen("fortune")
        local fortune_text

        if f == nil then
            fortune_text = "Goofy discord plugin"
        else
            fortune_text = f:read("*a")
            f:close()
        end

        require("cord").setup({
            editor = {
                tooltip = fortune_text,
            },

            display = {
                flavor = "accent",
            },

            timestamp = {
                enabled = false,
            },
        })
    end,
}
