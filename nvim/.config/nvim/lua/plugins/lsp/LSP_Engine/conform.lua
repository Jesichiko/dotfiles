return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			go = { "gofumpt", "goimports", "golines" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			javascript = { "prettier" },
			typescript = { "prettier" },
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
