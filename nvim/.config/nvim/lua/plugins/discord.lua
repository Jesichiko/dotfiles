return {
	"andweeb/presence.nvim",
	config = function()
		local f = io.popen("fortune")
		local fortune_text

		if f == nil then
			fortune_text = "Do you remember?"
		else
			fortune_text = f:read("*a")
			f:close()
		end

		require("presence").setup({
			auto_update = true,
			neovim_image_text = fortune_text,
			main_image = "file",
			show_time = true,
		})
	end,
}
