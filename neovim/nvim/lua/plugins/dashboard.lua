return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { {'nvim-tree/nvim-web-devicons'} },

    config = function()
      vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#C5C9C5' })

      require('dashboard').setup({
        theme = 'hyper',
        shortcut_type = 'number',

        -- for whatever reason this applies even after leaving the dashboard
        -- current fix is to disable hiding the statusline on the dashboard
        hide = {
          statusline = false,
        },

        config = {
          header = {
            [[                                                 ]],
            [[      _______                        /\          ]],
            [[____ |      /____ ____ ___  ____ ___/  \         ]],
            [[\_  \|     /_   /     \   \/   /___/    \  ___   ]],
            [[ /   \    / /  /_  \   \  /   /   /      \/   \  ]],
            [[/   \    /    / / _/   /\    /   /         /   \ ]],
            [[\____\  /\_____/\_____/  \__/___/________\/     \]],
            [[      \/                                  \_____/]],
            [[                                                 ]],
          },

          shortcut = {
            {
              desc = ' New',
              group = '@function',
              action = 'ene',
              key = 'n',
            },
            {
              desc = ' Update',
              group = '@string',
              action = 'Lazy update',
              key = 'u',
            },
            {
              desc = ' Telescope',
              group = '@property',
              action = 'Telescope',
              key = 't',
            },
            {
              desc = ' Config',
              group = '@operator',
              action = 'Neotree ~/dotfiles/neovim/nvim/',
              key = 'c',
            },
          },

          packages = { enable = true },
          project = { enable = false },
          mru = {
            enable = true,
            limit = 10,
          },

          footer = {},
        },
      })
    end,
  },
}
