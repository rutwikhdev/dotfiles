return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
		{ "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus file explorer" },
		{ "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal current file" },
	},
	init = function()
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("NeoTreeHijackDir", { clear = true }),
			once = true,
			callback = function()
				if vim.fn.argc() == 1 then
					local stat = vim.uv.fs_stat(vim.fn.argv(0))
					if stat and stat.type == "directory" then
						require("neo-tree.command").execute({ action = "show" })
						vim.api.nvim_buf_delete(0, { force = true })
					end
				end
			end,
		})
	end,
	opts = {
		filesystem = {
			follow_current_file = { enabled = false }, -- auto-focus active buffer
			use_libuv_file_watcher = true, -- live updates without polling
			hijack_netrw_behavior = "open_default", -- replace netrw
			filtered_items = {
				hide_dotfiles = false, -- show dotfiles
				hide_gitignored = true,
			},
		},
		window = {
			position = "right",
			width = 30,
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["H"] = "toggle_hidden",
			},
		},
		-- Don't open files in terminal/qf windows
		open_files_do_not_replace_types = { "terminal", "qf", "edgy" },
	},
}

-- return {
-- 	"nvim-neo-tree/neo-tree.nvim",
-- 	branch = "v3.x",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"MunifTanjim/nui.nvim",
-- 		"nvim-tree/nvim-web-devicons",
-- 	},
-- 	keys = {
-- 		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Reveal current file" },
-- 	},
-- 	opts = {
-- 		filesystem = {
-- 			follow_current_file = { enabled = true }, -- auto-focus active buffer
-- 			use_libuv_file_watcher = true, -- live updates without polling
-- 			hijack_netrw_behavior = "open_default", -- replace netrw
-- 			filtered_items = {
-- 				hide_dotfiles = false, -- show dotfiles
-- 				hide_gitignored = true,
-- 			},
-- 		},
-- 		window = {
-- 			position = "right",
-- 			width = 30,
-- 			mappings = {
-- 				["l"] = "open",
-- 				["h"] = "close_node",
-- 				["H"] = "toggle_hidden",
-- 			},
-- 		},
-- 		-- Don't open files in terminal/qf windows
-- 		open_files_do_not_replace_types = { "terminal", "qf", "edgy" },
-- 	},
-- }
