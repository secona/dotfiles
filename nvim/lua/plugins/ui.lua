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
		},
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end
	},

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
					-- component_separators = "",
					-- section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { 'filename' },
					lualine_x = { 'encoding' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' }
				},
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
		"stevearc/dressing.nvim",
		opts = {},
	},
}
