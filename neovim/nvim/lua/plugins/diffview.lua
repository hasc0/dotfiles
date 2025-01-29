return {
  {
    'sindrets/diffview.nvim',
    keys = {
      {
        '<leader>do',
        '<cmd>DiffviewOpen<cr>',
        desc = 'Diffview: Open',
      },
      {
        '<leader>dc',
        '<cmd>DiffviewClose<cr>',
        desc = 'Diffview: Close',
      },
      {
        '<leader>dt',
        '<cmd>DiffviewToggleFiles<cr>',
        desc = 'Diffview: Toggle Files',
      },
      {
        '<leader>df',
        '<cmd>DiffviewFocusFiles<cr>',
        desc = 'Diffview: Focus Files',
      },
      {
        '<leader>dr',
        '<cmd>DiffviewRefresh<cr>',
        desc = 'Diffview: Refresh',
      },
    },
  },
}
