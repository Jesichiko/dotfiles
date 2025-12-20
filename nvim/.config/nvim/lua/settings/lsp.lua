-- @Langs: @LSP

--@Ensure tools
local needed_servers = {
	"pylsp",
	"lua_ls",
	"gopls",
	"clangd",
	"jdtls",
	"typescript-language-server",
}

local needed_formatters = {
	"stylua",
	"ruff",
	"gofumpt",
	"goimports",
	"golines",
	"clang-format",
	"prettier",
}
require("mason-tool-installer").setup({ ensure_installed = vim.list_extend(needed_formatters, needed_servers) })

--@LSP server configs
local servers_config = {
	-- @python
	pylsp = {
		settings = {
			pylsp = {
				plugins = {
					ruff = { enabled = true },
				},
			},
		},
	},

	-- @lua
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
					globals = { "vim", "love" },
				},
			},
		},
	},

	-- @go
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

	-- @gleam
	gleam = {},
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

-- Enable servers (with or without pre-config)
for _, server in ipairs(servers) do
	local config = servers_config[server] or {}
	config.capabilities = capabilities

	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end
