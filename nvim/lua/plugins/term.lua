return {
	{
		"akinsho/toggleterm.nvim",
		init = function()
			function _G.set_terminal_keymaps()
				local opts = { noremap = true, silent = true }
				vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
		end,
		config = function()
			require("toggleterm").setup({
				open_mapping = [[\\]],
				direction = "float",
				float_opts = {
					border = "rounded"
				}
			})

			local Terminal = require('toggleterm.terminal').Terminal
			local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true })

			---@diagnostic disable-next-line: lowercase-global
			function _lazygit_toggle()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap("n", "\\g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
		end
	},
}
