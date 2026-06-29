require("set")
require("setup")
require("remap")
require("lazy_init")

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		-- Get the directory of the file/folder passed to nvim
-- 		local arg = vim.fn.argv(0)
--
-- 		if arg ~= "" then
-- 			local path = vim.fn.fnamemodify(arg, ":p")
--
-- 			-- If it's a directory, use it directly
-- 			if vim.fn.isdirectory(path) == 1 then
-- 				vim.cmd("cd " .. vim.fn.fnameescape(path))
-- 			else
-- 				-- Otherwise use the parent directory of the file
-- 				local dir = vim.fn.fnamemodify(path, ":h")
-- 				vim.cmd("cd " .. vim.fn.fnameescape(dir))
-- 			end
-- 		end
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local map = function(keys, fn, desc)
-- 			vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
-- 		end
--
-- 		map("gD", vim.lsp.buf.definition, "Go to definition")
-- 		map("gr", vim.lsp.buf.references, "Find references")
-- 		map("K", vim.lsp.buf.hover, "Hover docs")
-- 		map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
-- 		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
-- 		map("C-K", function()
-- 			vim.diagnostic.open_float(nil, {
-- 				focus = false,
-- 				scope = "line",
-- 				border = "rounded",
-- 			})
-- 		end, "Toggle Diagnostics")
-- 		-- map("<leader>f", function()
-- 		-- 	vim.lsp.buf.format({ async = true })
-- 		-- end, "Format buffer")
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	callback =
-- })
