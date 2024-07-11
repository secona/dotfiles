return {
	{
		"numToStr/Comment.nvim",
		lazy = false,
		opts = {}
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {}
	},
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	{
		"mg979/vim-visual-multi",
		config = function()
			vim.g.VM_Mono_hl   = 'guibg=#f9e2af'
			vim.g.VM_Extend_hl = 'guibg=#f9e2af'
			vim.g.VM_Cursor_hl = 'guibg=#f9e2af'
			vim.g.VM_Insert_hl = 'guibg=#f9e2af'
		end
	},
	{
		"christoomey/vim-tmux-navigator"
	},
	{
		"tpope/vim-sleuth"
	},
	{
		"tpope/vim-surround"
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			window = {
				border = "single"
			}
		}
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>Ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>Fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>Fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>Fh', builtin.help_tags, {})
		end
	}
}
