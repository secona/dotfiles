return {
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					separator_style = { "│", "│" },
					get_element_icon = function()
						-- local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype,
						-- 	{ default = false })
						-- return string.format(" %s", icon), hl
						return ""
					end,
					numbers = function(opts)
						return string.format(" %s", opts.ordinal)
					end,
					show_tab_indicators = false,
					indicator = { style = "none" }
				},
			})
		end
	},
}
