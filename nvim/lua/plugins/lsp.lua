return {
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {}
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip", -- for source
			"nvim-tree/nvim-web-devicons", -- for icons
			"onsails/lspkind.nvim", -- for pictograms
			"windwp/nvim-autopairs", -- for autopairs
			"saecki/crates.nvim", -- for source
			"j-hui/fidget.nvim", -- for lsp progress
		},
		config = function()
			-- Setup mason
			require("mason").setup({
				ui = {
					border = "rounded"
				},
			})

			-- Setup LSPs

			local lsp_on_attach = function(_, bufnr)
				-- Keymaps
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<C-Space>", vim.lsp.buf.hover, opts)
				vim.keymap.set('n', '<Leader>ee', vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<Leader>ej", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<Leader>ek", vim.diagnostic.goto_prev, opts)
				vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<Leader>dc', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', '<Leader>df', vim.lsp.buf.definition, opts)
				-- vim.keymap.set('n', '<Leader>rf', vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<Leader>f", vim.lsp.buf.format, opts)
			end

			local lsp_capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			local lsp_handlers = {
				["textDocument/hover"] = vim.lsp.with(
					vim.lsp.handlers.hover,
					{ border = "rounded" }
				),
				["textDocument/signatureHelp"] = vim.lsp.with(
					vim.lsp.handlers.signature_help,
					{ border = "rounded" }
				),
			}

			-- Initialize LSPs
			local lsp = require("lspconfig")
			require("mason-lspconfig").setup({
				handlers = {

					-- default handler (optional)
					function(server_name)
						lsp[server_name].setup({
							capabilities = lsp_capabilities,
							on_attach = lsp_on_attach,
							handlers = lsp_handlers,
						})
					end,

					-- rust_analyzer handler
					["rust_analyzer"] = function()
						lsp.rust_analyzer.setup({
							capabilities = lsp_capabilities,
							on_attach = lsp_on_attach,
							handlers = lsp_handlers,
							settings = {
								['rust-analyzer'] = {
									cargo = {
										features = "all"
									}
								}
							}
						})
					end,

					-- lua_ls handler
					["lua_ls"] = function()
						lsp.lua_ls.setup({
							capabilities = lsp_capabilities,
							on_attach = lsp_on_attach,
							handlers = lsp_handlers,
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
					end
				}
			})

			-- Config diagnostics
			vim.diagnostic.config({
				float = {
					border = "rounded",
					style = "minimal",
				}
			})

			-- Config icons
			for sign, icon in pairs({
				DiagnosticSignError = "",
				DiagnosticSignWarning = "",
				DiagnosticSignHint = "",
				DiagnosticSignInformation = "",
			}) do
				vim.fn.sign_define(sign, {
					texthl = sign,
					text = icon,
					numhl = sign,
				})
			end

			-- Config cmp
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')

			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)

			cmp.setup({
				window = {
					completion = {
						border = 'rounded',
						scrollbar = true,
						maxwidth = 50,
					},
					documentation = {
						border = 'rounded',
						scrollbar = false,
					},
				},
				completion = { completeopt = "menu,menuone,preview,noselect" },
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							local entry = cmp.get_selected_entry()
							if not entry then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
							else
								cmp.confirm()
							end
						else
							fallback()
						end
					end, { "i", "s", "c" }),
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({ select = true }),
						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
					}),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "cmp_luasnip" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "crates" }
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "..."
					})
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end
				}
			})
		end
	},

	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		opts = {},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			}
		},
	},

	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
					border = "rounded",
				},
			}
		}
	},
}
