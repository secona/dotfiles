vim.g.mapleader = " "

local opts = {
	noremap = true,
	silent = true,
}

vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("n", "<M-h>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<M-l>", ":bnext<CR>", opts)
