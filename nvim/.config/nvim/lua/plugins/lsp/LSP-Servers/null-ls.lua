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

				-- Python
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				require("none-ls.diagnostics.flake8"),

				-- Kotlin
				null_ls.builtins.formatting.ktlint,
				null_ls.builtins.diagnostics.ktlint,

				-- Haskell
				-- null_ls.builtins.formatting.hls,
				-- null_ls.builtins.diagnostics.hlint,

				-- Java
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.diagnostics.checkstyle.with({
					extra_args = { "-c", "/google_checks.xml" },
				}),

				-- C
				null_ls.builtins.formatting.clang_format,
				require("none-ls.diagnostics.cpplint"),

				-- JavaScript (and TypeScript)
				null_ls.builtins.formatting.prettier,
				require("none-ls.diagnostics.eslint_d"),

                -- Julia

				-- hypr
				-- in -> core/autocmds.lua

				-- bash
				null_ls.builtins.formatting.shfmt,
				-- Diagnostics -> core/autocmds.lua
			},
		})
	end,
}
