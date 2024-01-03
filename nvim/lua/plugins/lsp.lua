return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lsp = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local opts = { noremap = true, silent = true }
			local on_attach = function(_, bufnr)
				opts.buffer = bufnr

				-- Keymaps
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<C-Space>", vim.lsp.buf.hover, opts)
				vim.keymap.set('n', '<Leader>ee', vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<Leader>ej", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<Leader>ek", vim.diagnostic.goto_prev, opts)
				vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<Leader>dc', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', '<Leader>df', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', '<Leader>rf', vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<Leader>f", vim.lsp.buf.format, opts)

				-- Icons
				local icons = {
					DiagnosticSignError = "",
					DiagnosticSignWarning = "",
					DiagnosticSignHint = "",
					DiagnosticSignInformation =  "",
				}

				for sign, icon in pairs(icons) do
					vim.fn.sign_define(sign, { texthl = sign, text = icon, numhl = sign})
				end
			end

			local capabilities = cmp_nvim_lsp.default_capabilities()
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(
					vim.lsp.handlers.hover,
					{ border = "rounded" }
				),
				["textDocument/signatureHelp"] = vim.lsp.with(
					vim.lsp.handlers.signature_help,
					{ border = "rounded" }
				),
			}

			-- Lsp initializations
			lsp.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				handlers = handlers
			})

			lsp.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				handlers = handlers
			})

			lsp.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				handlers = handlers,
				settings = {
					Lua = {
						diagnostics = {
							globals = {
								"vim",
								"require",
							},
						},
					},
				},
			})

			lsp.tsserver.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				handlers = handlers
			})

			lsp.tailwindcss.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				handlers = handlers
			})

			-- lsp.prettier.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	handlers = handlers,
			-- })

			lsp.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				handlers = handlers,
			})

			lsp.docker_compose_language_service.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				handlers = handlers,
			})

			lsp.dockerls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				handlers = handlers,
			})

			vim.diagnostic.config({
				float = { border = "rounded" }
			})
		end
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			local trouble = require('trouble')
			trouble.setup()

			vim.keymap.set("n", "<Leader>xx", trouble.toggle)
		end
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim"
		},
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded"
				},
				ensure_installed = {
					"docker_compose_language_service",
					"dockerls",
					"gopls",
					"lua_ls",
					"prettier",
					"pyright",
					"rust_analyzer",
					"tailwindcss",
					"tsserver",
				}
			})

			require("mason-lspconfig").setup()
		end
	},
}
