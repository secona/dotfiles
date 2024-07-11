return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			-- Move to previous/next
			map('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
			map('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)

			-- Re-order to previous/next
			map('n', '<A-j>', '<Cmd>BufferMovePrevious<CR>', opts)
			map('n', '<A-k>', '<Cmd>BufferMoveNext<CR>', opts)

			-- Goto buffer in position...
			map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
			map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
			map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
			map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
			map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
			map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
			map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
			map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
			map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
			map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

			-- Pin/unpin buffer
			map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

			-- Close buffer
			map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

			map('n', '<leader>bc', '<Cmd>BufferCloseAllButCurrent<CR>', opts)

			-- Magic buffer-picking mode
			map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

			-- Sort automatically by...
			map('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
			map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', opts)
			map('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
			map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
			map('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
		end,
		opts = {
			icons = {
				-- Configure the base icons on the bufferline.
				-- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
				buffer_index = true,
				buffer_number = false,
				button = '',

				-- Enables / disables diagnostic symbols
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
					[vim.diagnostic.severity.WARN] = { enabled = true, icon = ' ' },
					[vim.diagnostic.severity.INFO] = { enabled = false, icon = ' ' },
					[vim.diagnostic.severity.HINT] = { enabled = true, icon = ' ' },
				},
				gitsigns = {
					added = { enabled = true, icon = ' ' },
					changed = { enabled = true, icon = ' ' },
					deleted = { enabled = true, icon = ' ' },
				},
				filetype = {
					-- Sets the icon's highlight group.
					-- If false, will use nvim-web-devicons colors
					custom_colors = false,

					-- Requires `nvim-web-devicons` if `true`
					enabled = true,
				},
				separator = { left = '▎', right = '' },

				-- If true, add an additional separator at the end of the buffer list
				separator_at_end = true,

				-- Configure the icons on the bufferline when modified or pinned.
				-- Supports all the base icon options.
				modified = { button = '●' },
				pinned = { button = '', filename = true },

				-- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
				preset = 'default',

				-- Configure the icons on the bufferline based on the visibility of a buffer.
				-- Supports all the base icon options, plus `modified` and `pinned`.
				alternate = { filetype = { enabled = false } },
				current = { buffer_index = true },
				inactive = { button = '×' },
				visible = { modified = { buffer_number = false } },
			},
		},
	}
}
