local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("config/options")
require("config/keymaps")

require("lazy").setup("plugins",
	{
		ui = {
			border = "rounded"
		}
	}
)
