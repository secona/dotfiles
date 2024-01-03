return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
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
					git_ignored = false,
					dotfiles = true,
				},
				diagnostics = {
					enable = true,
				},
				modified = {
					enable = true,
				},
			})
		end,
		init = function ()
			vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
		end
	},
}
