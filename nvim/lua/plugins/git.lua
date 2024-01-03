return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			preview_config = {
				border = "rounded"
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "<Leader>hj", gs.next_hunk)
				map("n", "<Leader>hl", gs.next_hunk)
				map("n", "<Leader>hh", gs.prev_hunk)
				map("n", "<Leader>hk", gs.prev_hunk)

				-- Hunk previews
				map("n", "<Leader>hP", gs.preview_hunk)
				map("n", "<Leader>hp", gs.preview_hunk_inline)

				-- Reset hunk
				map("n", "<Leader>hr", gs.reset_hunk)
				map("v", "<Leader>hr", function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)

				-- Diff
				-- map("n", "<Leader>hd", function() gs.diffthis("~1", { split = "botright" }) end)
			end,
		}
	},
}
