return {
	{
		"vague-theme/vague.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("vague")
		end,
	},
	{
		"xiantang/darcula-dark.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("darcula-dark")
		end,
	},
	{
		"kepano/flexoki-neovim",
		name = "flexoki",
		lazy = true,
		priority = 100,
		config = function()
			vim.cmd.colorscheme("flexoki-light")
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		lazy = true,
		config = function()
			-- require("onedark").setup({
			-- 	style = "darker",
			-- })
			require("onedark").load()
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("gruvbox").setup({
				contrast = "soft",
			})
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("dracula").setup({
				theme = "dracula-soft",
				overrides = {
					CursorLine = { bg = "#343641" },
				},
			})

			vim.cmd.colorscheme("dracula-soft")
		end,
	},
	{
		"loctvl842/monokai-pro.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("monokai-pro").setup()
			vim.cmd.colorscheme("monokai-pro-classic")
		end,
	},
	{
		"nickkadutskyi/jb.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("jb")
		end,
	},
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-frappe")
		end,
	},
	{
		"pappasam/papercolor-theme-slim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("PaperColorSlim")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-storm")
		end,
	},
	{
		"gbprod/nord.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("nord").setup({})
			vim.cmd.colorscheme("nord")
		end,
	},
}
