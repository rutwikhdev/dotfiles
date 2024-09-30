return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  event = "VeryLazy",
  keys = {
    { "<leader>pv", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  config = function()
    require('neo-tree').setup {
      window = {
        position = 'right',
        width = 40,
      },
    }
  end,
}
