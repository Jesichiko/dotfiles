local diagnostics = vim.diagnostic

local diagnostics_config = {
	virtual_text = true,
	signs = {
		text = {
			[diagnostics.severity.ERROR] = " ",
			[diagnostics.severity.WARN] = " ",
			[diagnostics.severity.INFO] = "󰋼 ",
			[diagnostics.severity.HINT] = "󰌶",
		},
		numhl = {
			[diagnostics.severity.ERROR] = "DiagnosticSignError",
			[diagnostics.severity.WARN] = "DiagnosticSignWarn",
			[diagnostics.severity.INFO] = "DiagnosticSignInfo",
			[diagnostics.severity.HINT] = "DiagnosticSignHint",
		},
		texthl = {
			[diagnostics.severity.ERROR] = "DiagnosticSignError",
			[diagnostics.severity.WARN] = "DiagnosticSignWarn",
			[diagnostics.severity.INFO] = "DiagnosticSignInfo",
			[diagnostics.severity.HINT] = "DiagnosticSignHint",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		source = true,
		border = "rounded",
	},
}

local python_config = {

	init = function(capabilities)
		return {
			capabilities = capabilities,

			cmd = function()
				local venv_pylsp = vim.fn.getcwd() .. "/.venv/bin/pylsp"
				if vim.fn.executable(venv_pylsp) == 1 then
					return { venv_pylsp }
				end
				return { "pylsp" } -- fallback a Mason
			end,

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
		}
	end,
}

local lua_config = {
	init = function(capabilities)
		return {
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
		}
	end,
}

local go_config = {
	init = function(capabilities)
		return {
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		}
	end,
}

return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local mason_lspconfig = require("mason-lspconfig")

		for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
			if server ~= "pylsp" then
				vim.lsp.config(server, { capabilities = capabilities })
			end
		end

		-- pylsp
		vim.lsp.config("pylsp", python_config.init(capabilities))

		-- lua
		vim.lsp.config("lua_ls", lua_config.init(capabilities))

		-- go
		vim.lsp.config("gopls", go_config.init(capabilities))

		-- gleam
		vim.lsp.enable("gleam")

		vim.diagnostic.config(diagnostics_config)
	end,
}
