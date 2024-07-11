return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			term_colors = false,
			lazy = false,
			priority = 1000,
			transparent_background = true,
			color_overrides = {
				mocha = {
					base = "#000000",
				},
			},
			integrations = {
				barbar = true,
				gitsigns = true,
				barbecue = {
					dim_dirname = true, -- directory name is dimmed by default
					bold_basename = true,
					dim_context = false,
					alt_background = false,
				},
				mason = true,
				nvimtree = true,
				neotree = true,
				treesitter = true,
				treesitter_context = true,
				lsp_trouble = true,
				cmp = true,
				illuminate = {
					enabled = true,
					lsp = false
				},
				rainbow_delimiters = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				which_key = true,
				fidget = true,
				telescope = {
					enabled = true,
					style = "nvchad"
				}
			}
		},
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end
	},

	{
		"nvim-lualine/lualine.nvim",
		init = function()
			require('lualine').setup {
				options = {
					theme = "catppuccin"
				}
			}
		end
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
		"stevearc/dressing.nvim",
		opts = {},
	},

	{
		"RRethy/vim-illuminate",
		-- opts = {},
	},

	{
		"petertriho/nvim-scrollbar",
		opts = {
			handle = {
				blend = 0,
				color = "#89b4fa"
			},
			handlers = {
				search = true
			},
		},
	},

	{
		"kevinhwang91/nvim-hlslens",
		opts = {
			calm_down = true,
			nearest_only = true,
		},
	},

	{
		"rasulomaroff/reactive.nvim",
		opts = {
			builtin = {
				cursorline = true,
				cursor = true,
				modemsg = true
			},
			load = {
				'catppuccin-mocha-cursor',
				'catppuccin-mocha-cursorline'
			}
		}
	}
}
