return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'hard'
    end,
  },
  {
    'eddyekofo94/gruvbox-flat.nvim',
    priority = 1000,
    enabled = true,
    config = function()
      vim.g.gruvbox_flat_style = "hard"
      vim.cmd([[colorscheme gruvbox-flat]])
    end,
  }
}
