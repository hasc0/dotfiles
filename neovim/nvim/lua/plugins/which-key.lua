return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',

    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps',
      },
    },

    config = function()
      require('which-key').setup({
        preset = 'modern',
        -- TODO: fix icons
        icons = { mappings = true },
      })

      require('which-key').add {
        { '<leader>c', group = 'Code' },
        { '<leader>d', group = 'Document', },
        { '<leader>h', group = 'Git' },
        { '<leader>r', group = 'Rename' },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Toggle' },
        { '<leader>w', group = 'Workspace' },
        { '<leader>x', group = 'Trouble' },

        -- visual mode
        { '<leader>h', desc = 'Git', mode = 'v' },
      }
    end,
  },
}
