return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },

    cmd = 'Neotree',

    keys = {
      { '\\', '<cmd>Neotree reveal right<cr>', { desc = 'Neotree: Reveal' } },
    },

    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },

      source_selector = {
        winbar = true,
        statusline = false,
      },
    },
  },
}
