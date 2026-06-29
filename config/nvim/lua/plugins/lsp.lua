-- plugins/lsp.lua
return {
	-- LSP progress in the corner
	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	-- Completion engine + sources
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local caps = require("cmp_nvim_lsp").default_capabilities()

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			vim.lsp.config("lua_ls", { capabilities = caps })
			vim.lsp.config("ts_ls", { capabilities = caps })
			vim.lsp.config("gopls", { capabilities = caps })
			vim.lsp.config("basedpyright", {
				capabilities = caps,
				settings = {
					basedpyright = {
						analysis = { typeCheckingMode = "standard" },
						disableOrganizeImports = true,
					},
				},
				init_options = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							autoImportCompletions = true,
						},
					},
				},
			})
		end,
	},

	-- Mason + lspconfig bridge — auto-enables installed servers
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			-- Add whatever servers you need here — Mason installs + enables them
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"basedpyright",
			},
		},
	},
}
