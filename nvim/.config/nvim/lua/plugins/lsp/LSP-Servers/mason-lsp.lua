return {
	--mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	--mason-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
	--lsp
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local mason_lspconfig = require("mason-lspconfig")

			local function get_pylsp_cmd()
				local venv_pylsp = vim.fn.getcwd() .. "/.venv/bin/pylsp"
				if vim.fn.executable(venv_pylsp) == 1 then
					return { venv_pylsp }
				end
				return { "pylsp" } -- fallback a Mason
			end

			for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
				if server ~= "jdtls" and server ~= "pylsp" then
					vim.lsp.config(server, {
						capabilities = capabilities,
					})
				end
			end

			-- pylsp
			vim.lsp.config("pylsp", {
				capabilities = capabilities,
				cmd = get_pylsp_cmd(),
				settings = {
					pylsp = {
						plugins = {
							ruff = {
								enabled = true,
							},
							pycodestyle = { enabled = false },
							pyflakes = { enabled = false },
							pylint = { enabled = false },
							mccabe = { enabled = false },
						},
					},
				},
			})

			vim.lsp.config("jdtls", {
				capabilities = capabilities,
				cmd = {
					"jdtls",
					"-data",
					vim.fn.expand("~/.cache/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")),
					"--jvm-arg=-Xms512m",
					"--jvm-arg=-Xmx2G",
					"--jvm-arg=--add-modules=ALL-SYSTEM",
					"--jvm-arg=--add-opens=java.base/java.util=ALL-UNNAMED",
					"--jvm-arg=--add-opens=java.base/java.lang=ALL-UNNAMED",
					"--jvm-arg=--add-opens=java.base/sun.nio.fs=ALL-UNNAMED",
					"--jvm-arg=--enable-native-access=ALL-UNNAMED",
				},
				root_markers = { "pom.xml", "build.gradle", ".git" },
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = "JavaSE-24",
									path = "/usr/lib/jvm/java-24-openjdk",
								},
							},
						},
					},
				},
				on_attach = function(client, bufnr)
					vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
				end,
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						workspace = {
							library = {
								"${3rd}/love2d/library",
							},
						},
					},
				},
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = "󰋼 ",
						[vim.diagnostic.severity.HINT] = "󰌶",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
						[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
						[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
						[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					},
					texthl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
						[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
						[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
						[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					source = true,
					border = "rounded",
				},
			})
		end,
	},
}
