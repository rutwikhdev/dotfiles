-- Only show diagnostics when hovering or pressing Ctrl+k
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, {
			focus = false,
			scope = "line",
			border = "rounded",
		})
	end,
})
-- Show line diagnostics on a keymap
-- vim.keymap.set("n", "<C-k>", function()
--   vim.diagnostic.open_float(nil, {
--     scope = "line",
--     focus = false,
--     border = "rounded",
--   })
-- end, { desc = "Show line diagnostics" })
