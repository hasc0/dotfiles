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
        { '<leader>c_', hidden = true },
        { '<leader>d', group = 'Document', },
        { '<leader>d_', hidden = true },
        { '<leader>h', group = 'Git' },
        { '<leader>h_', hidden = true },
        { '<leader>r', group = 'Rename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = 'Search' },
        { '<leader>s_', hidden = true },
        { '<leader>t', group = 'Toggle' },
        { '<leader>t_', hidden = true },
        { '<leader>w', group = 'Workspace' },
        { '<leader>w_', hidden = true },
        { '<leader>x', group = 'Trouble' },
        { '<leader>w_', hidden = true },

        -- visual mode
        { '<leader>h', desc = 'Git', mode = 'v' },
      }
    end,
  },
}
