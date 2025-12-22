---@return string|osdate
local function get_datetime_if_fullscreen()
	if vim.o.lines - vim.o.cmdheight < 39 then
		return ""
	else
		return os.date("%I:%M%p")
	end
end

vim.api.nvim_del_mark("M")
---@return string
local function markM()
	local ok, markObj = pcall(vim.api.nvim_get_mark, "M", {})
	if not ok then
		return ""
	end

	local markLn = markObj[1]
	local markBufname = vim.fs.basename(markObj[4])
	if markBufname == "" then
		return ""
	end

	return " mark at " .. markBufname:gsub("%.%w+$", "") .. ":" .. markLn
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.icons",
	},
	config = function()
		require("lualine").setup({
			-- general_options
			options = {
				theme = "auto",
				section_separators = "",
				component_separators = "::",
				disabled_filetypes = { "alpha", "Outline" },
			},
			sections = {
				-- vim mode
				lualine_a = {
					{
						"mode",
						fmt = function(mode)
							return mode:sub(1, 1)
						end,
					},
				},
				-- file
				lualine_b = {
					{
						"filetype",
						icon_only = true,
						padding = { left = 1, right = 0 },
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						color = { gui = "bold" },
					},
				},
				-- diagnostics and git branch
				lualine_x = {
					{
						markM,
						color = { gui = "bold" },
					},
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						update_in_insert = true,
					},
					{
						"branch",
						icon = "",
						color = { gui = "bold" },
					},
				},
				lualine_y = {},
				-- datetime
				lualine_z = {
					{
						get_datetime_if_fullscreen,
					},
				},
			},
			extensions = { "mason", "lazy", "oil" },
		})
	end,
}
