return {
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function ()
			require("crates").setup()
		end
	}
}
