local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			term_colors = true,
			transparent_background = true,
			color_overrides = {
				mocha = {
					base = "#000000",
				},
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
					component_separators = "",
					section_separators = { left = "", right = "" },
				}
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		init = function()
			require("ibl").setup({
				indent = {
					char = "▏"
				},
				whitespace = {
					remove_blankline_trail = false,
				},
				scope = {
					enabled = true,
					show_end = false
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter").setup()
		end,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua" },

			highlight = {
				enable = true,
				use_languagetree = true,
			},

			indent = { enable = true },
		}
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = { "", "" },
					get_element_icon = function(element)
						local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype,
							{ default = false })
						return string.format(" %s", icon), hl
					end,
					numbers = function(opts)
						return string.format(" %s", opts.ordinal)
					end,
					show_tab_indicators = false,
					indicator = { style = "none" }
				},
				highlights = {
					numbers = {
						fg = "#000000",
						bg = "#89b4fa",
						italic = false,
						bold = false,
					},
					numbers_selected = {
						fg = "#000000",
						bg = "#fab387",
						italic = false,
						bold = false,
					},
					buffer_selected = {
						fg = "#fab387",
						italic = false,
						bold = false
					}
				}
			})
		end
	},

	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {}
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"nvim-tree/nvim-web-devicons",
			"onsails/lspkind.nvim",
			"windwp/nvim-autopairs"
		},
		config = function()
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
					completion = { -- rounded border; thin-style scrollbar
						border = 'rounded',
						scrollbar = true,
						maxwidth = 50,
					},
					documentation = { -- no border; native-style scrollbar
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
					{ name = "path" }
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
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim"
		},
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded"
				}
			})

			require("mason-lspconfig").setup()
		end
	},

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
			local on_attach = function(client, bufnr)
				opts.buffer = bufnr

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

				vim.fn.sign_define(
					"DiagnosticSignError",
					{ texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticSignError" }
				)
				vim.fn.sign_define(
					"DiagnosticSignWarning",
					{ texthl = "DiagnosticSignWarning", text = "", numhl = "DiagnosticSignWarning" }
				)
				vim.fn.sign_define(
					"DiagnosticSignHint",
					{ texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" }
				)
				vim.fn.sign_define(
					"DiagnosticSignInformation",
					{ texthl = "DiagnosticSignInformation", text = "", numhl = "DiagnosticSignInformation" }
				)
			end

			local capabilities = cmp_nvim_lsp.default_capabilities()
			local handlers =  {
			  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
			  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"}),
			}

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
				handlers = handlers
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

			vim.diagnostic.config({
				float = { border = "rounded" }
			})
		end
	},

	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()
		end
	},

	{
		"christoomey/vim-tmux-navigator"
	},

	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				-- view = {
				-- 	signcolumn = "no"
				-- },
				renderer = {
					icons = {
						git_placement = "signcolumn",
						diagnostics_placement = "signcolumn",
						glyphs = {
							default = "󰈚",
							symlink = "",
							folder = {
								default = "",
								empty = "",
								empty_open = "",
								open = "",
								symlink = "",
								symlink_open = "",
								arrow_open = "",
								arrow_closed = "",
							},
							git = {
								unstaged = "U",
								staged = "S",
								unmerged = "UM",
								renamed = "R",
								deleted = "D",
								untracked = "",
								ignored = "I",
							},
						}
					},
					indent_markers = {
						enable = true
					}
				},
				update_cwd = true,
				filters = {
					dotfiles = false,
				},
				diagnostics = {
					enable = true,
				},
				modified = {
					enable = true,
				},
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

		end
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			preview_config = {
				border = "rounded"
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "<Leader>hj", gs.next_hunk)
				map("n", "<Leader>hl", gs.next_hunk)
				map("n", "<Leader>hh", gs.prev_hunk)
				map("n", "<Leader>hk", gs.prev_hunk)

				-- Hunk previews
				map("n", "<Leader>hP", gs.preview_hunk)
				map("n", "<Leader>hp", gs.preview_hunk_inline)

				-- Reset hunk
				map("n", "<Leader>hr", gs.reset_hunk)
				map("v", "<Leader>hr", function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)

				-- Diff
				-- map("n", "<Leader>hd", function() gs.diffthis("~1", { split = "botright" }) end)
			end,
		}
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				mode = "topline"
			})
		end
	},

	{
		"tpope/vim-sleuth"
	},

	{
		"tpope/vim-surround"
	},

	{
		"akinsho/toggleterm.nvim",
		opts = {
			open_mapping = [[<Leader>t]],
			direction = "float",
			float_opts = {
				border = "rounded"
			}
		},
		init = function ()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
		end
	}
})

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-h>", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>xx", require("trouble").toggle)

vim.cmd.colorscheme("catppuccin-mocha")
