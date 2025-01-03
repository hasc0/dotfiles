return {
  {
    'rebelot/kanagawa.nvim',
    opts = { transparent = false },
    priority = 1000, -- load this before all the other start plugins
    init = function()
      -- load the colorscheme here
      vim.cmd.colorscheme 'kanagawa-dragon'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
