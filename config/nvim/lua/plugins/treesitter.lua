return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Install your parsers (only installs if not already present)
		local ts = require("nvim-treesitter")
		local installed = require("nvim-treesitter.config").get_installed()
		local want = {
			"lua",
			"vim",
			"vimdoc",
			"markdown",
			"markdown_inline",
			"bash",
			"python",
			"typescript",
			"javascript",
			"json",
			"go",
		}
		local to_install = vim.tbl_filter(function(p)
			return not vim.tbl_contains(installed, p)
		end, want)
		if #to_install > 0 then
			ts.install(to_install)
		end

		-- Enable highlighting + treesitter indentation on each buffer
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
