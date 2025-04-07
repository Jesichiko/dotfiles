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
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
                lspconfig[server].setup({
                    capabilities = capabilities,
                })
            end

            lspconfig.lua_ls.setup({
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
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
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
                    source = true, -- float window
                    border = "rounded",
                },
            })
        end,
    },
}
