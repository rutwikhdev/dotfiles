return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#1a1b26',
				base01 = '#1a1b26',
				base02 = '#777e76',
				base03 = '#777e76',
				base04 = '#979f96',
				base05 = '#d7dcd6',
				base06 = '#d7dcd6',
				base07 = '#d7dcd6',
				base08 = '#cd9180',
				base09 = '#cd9180',
				base0A = '#9aa797',
				base0B = '#78b676',
				base0C = '#cbd4ca',
				base0D = '#9aa797',
				base0E = '#b8c5b6',
				base0F = '#b8c5b6',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#777e76',
				fg = '#d7dcd6',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#9aa797',
				fg = '#1a1b26',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#777e76' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#cbd4ca', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#b8c5b6',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#9aa797',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#9aa797',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#cbd4ca',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#78b676',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#979f96' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#979f96' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#777e76',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
