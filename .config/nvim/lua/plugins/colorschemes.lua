return {
  {
    "jacoborus/tender.vim",
    lazy = true,
    priority = 1000,
    config = function ()
      vim.cmd[[colorscheme tender]]
    end
  },
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd[[colorscheme nord]]
    end
  },
}
