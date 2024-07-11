return {
	{
		"akinsho/toggleterm.nvim",
		init = function()
			vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
		end,
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-_>]], -- ctrl+/
				direction = "float",
				float_opts = {
					border = "rounded"
				}
			})
		end
	},
}
