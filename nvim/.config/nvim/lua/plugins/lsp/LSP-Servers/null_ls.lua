--none-ls, fork of null-ls
return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.selene,

				-- Kotlin
				null_ls.builtins.formatting.ktlint,
				null_ls.builtins.diagnostics.ktlint,

				-- Java
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.diagnostics.checkstyle.with({
					extra_args = { "-c", "/google_checks.xml" },
				}),

				-- Ruby

				-- Go
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.formatting.goimports_reviser,
				null_ls.builtins.formatting.golines,

				-- C
				null_ls.builtins.formatting.clang_format,
				require("none-ls.diagnostics.cpplint"),

				-- JavaScript/TypeScript
				null_ls.builtins.formatting.prettier,
				require("none-ls.diagnostics.eslint_d"),

				-- Protobuff
				null_ls.builtins.formatting.buf,

				-- hypr
				-- formatting -> core/autocmds.lua

				-- bash
				null_ls.builtins.formatting.shfmt,
				-- diagnostics -> core/autocmds.lua
			},
		})
	end,
}
