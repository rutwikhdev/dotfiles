return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = false,
      component_separators = '·',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '' } },
      },
      lualine_b = { 'filename', 'branch' },
      lualine_c = { 'fileformat' },
      lualine_x = {
        {
          function()
              local reg = vim.fn.reg_recording()
              if reg == "" then return "no-macro" end -- not recording
              return "recording to " .. reg
          end,
        },
      },
      lualine_y = { 'filetype', 'progress' },
      lualine_z = {
        { 'location', separator = { right = '' } },
      },
    },
  },
}
