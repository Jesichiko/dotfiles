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
	update_in_insert = true,
	severity_sort = true,
	float = {
		source = true,
		border = "rounded",
	},
})

local servers_config = {
	pylsp = {
		settings = {
			pylsp = {
				plugins = {
					ruff = { enabled = true },
				},
			},
		},
	},

	lua_ls = {
		settings = {
			Lua = {
				workspace = {
					library = {
						vim.env.VIMRUNTIME,
						"${3rd}/love2d/library",
					},
				},
				diagnostics = {
					globals = { "vim" },
					disable = { "mixed_table" },
				},
			},
		},
	},

	gopls = {
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
	},

    gleam = {}
}

local capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities()
)

local servers = vim.list_extend(
    require("mason-lspconfig").get_installed_servers(),
    { "gleam" } -- not in Mason
)

for _, server in ipairs(servers) do
	local config = servers_config[server] or {}
	config.capabilities = capabilities

	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end
