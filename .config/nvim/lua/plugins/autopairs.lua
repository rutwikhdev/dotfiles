-- File: lua/custom/plugins/autopairs.lua

return {
  'windwp/nvim-autopairs',
  -- Optional dependency
  event = "InsertEnter",
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup({
      fast_wrap = {}
    })
    -- If you want to automatically add `(` after selecting a function or method
    -- local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    -- local cmp = require 'cmp'
    -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
