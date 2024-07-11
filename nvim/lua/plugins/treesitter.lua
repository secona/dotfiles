return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {},
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					use_languagetree = true,
				},
				rainbow = {
					enable = true,
				},
				indent = {
					enable = true
				},
			})
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				mode = "topline"
			})

			vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			require("rainbow-delimiters.setup").setup()
		end
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	}
}
