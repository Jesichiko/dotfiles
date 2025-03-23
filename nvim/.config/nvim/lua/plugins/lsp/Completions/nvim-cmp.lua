return {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load() -- Friendly-Snippets
		cmp.setup({

			-- Sources for autocompletion
			sources = cmp.config.sources({
				{ name = "zsh" }, -- cmp-zsh
				{ name = "luasnip" }, -- Luasnip (Snippet engine)
				{ name = "nvim_lsp" }, -- cmp-nvim-lsp
			}, {
				{ name = "buffer" }, -- Attached to the current buffer
			}),

			-- Sources for snippets
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- Luasnip
				end,
			},

			-- Window mode
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			-- Keymaps
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-c>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
		})
	end,
}
