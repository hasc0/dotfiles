return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { {'nvim-tree/nvim-web-devicons'} },

    config = function()
      local date_time = os.date('󰃰 %A, %d %B %Y | %I:%M %p')

      local align_center = function(ref_text, text)
        local padding = #ref_text - #text
        local left_pad = math.floor(padding / 2)
        local right_pad = (padding - left_pad)
        return string.rep(' ', left_pad) .. text .. string.rep(' ', right_pad)
      end

      vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#CCC7B4' })
      vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#807A58' })

      require('dashboard').setup({
        theme = 'hyper',
        shortcut_type = 'number',

        -- handle hiding and unhiding statusline with an autocmd
        hide = {
          statusline = false,
        },

        config = {
          header = {
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
            [[      _______                        /\          ]],
            [[____ |      /____ ____ ___  ____ ___/  \         ]],
            [[\_  \|     /_   /     \   \/   /___/    \  ___   ]],
            [[ /   \    / /  /_  \   \  /   /   /      \/   \  ]],
            [[/   \    /    / / _/   /\    /   /         /   \ ]],
            [[\____\  /\_____/\_____/  \__/___/________\/     \]],
            [[      \/                                  \_____/]],
            [[                                                 ]],
            align_center('                                                 ', date_time),
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
              action = 'Neotree right ~/dotfiles/neovim/nvim/',
              key = 'c',
            },
          },

          packages = { enable = false },
          project = { enable = false },
          mru = {
            enable = true,
            limit = 5,
          },

          footer = function()
            local padding = '                                                     '
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local version = ' ' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch
            return {
              [[                                                     ]],
              [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠉⢻⣀⣧⣤⣽⣦⣤⣄⠀   ⠀⠀⠀⠀⠀⠀⡴⠟⠛⣉⣉⡉⠉⠈⠉⠉⠉⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀]],
              [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⡧⠖⠛⠉⠉⠉⠀⠀⠐⠒⢢⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⣠⣲⣾⣿⢿⣷⢶⡄⠀⠀⣽⣿⣿⣿⣿⡿⠟⣿⣿ ]],
              [[⢽⣿⣿⣿⣿⣿⣿⣿⣿⡷⠀⠀⠀⣠⣶⣶⣿⣟⣿⣶⡅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⢿⣿⣿⣿⣿⠀⣿⡀⠀⢻⣬⣙⡻⡿⣡⣾⣿⣿ ]],
              [[ ⢻⣫⢿⣿⣿⣿⣿⠘⢧⠁⠀⣻⡏⠸⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⣉⣛⣋⣡⡴⠃⠀⠀⣿⣿⣿⠟⣠⡛⢿⣿⣿⣷]],
              [[    ⣿⢿⣿⣿⣟⡆⠀⠀⠉⠿⣦⣈⣉⣉⠤⠚⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡟⣡⣶⣿⣿⣾⣿⣿⣿]],
              [[                                                     ]],
              align_center(padding, stats.loaded .. '/' .. stats.count .. ' Plugins Loaded in ' .. ms .. 'ms'),
              align_center(padding, version),
            }
          end,
        },
      })

      vim.api.nvim_create_augroup('dashboard_statusline', { clear = true })

      vim.api.nvim_create_autocmd('FileType', {
        group = 'dashboard_statusline',
        pattern = 'dashboard',
        command = 'set laststatus=0',
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = 'dashboard_statusline',
        pattern = 'dashboard',
        callback = function()
          vim.api.nvim_create_autocmd('BufUnload', {
            group = 'dashboard_statusline',
            buffer = 0,
            command = 'set laststatus=2',
          })
        end,
      })
    end,
  },
}
