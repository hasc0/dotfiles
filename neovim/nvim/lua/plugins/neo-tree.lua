return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },

  cmd = 'Neotree',

  keys = {
    { '\\', ':Neotree reveal right<CR>', { desc = 'NeoTree reveal' } },
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
}
