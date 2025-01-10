return {
  {
    'rasulomaroff/reactive.nvim',
    init = function ()
      vim.opt.cursorline = true
      vim.opt.guicursor:append 'a:CursorCustom'
    end,

    config = function()
      require('reactive').add_preset({
        name = 'custom',

        -- inactive window
        static = {
          winhl = {
            inactive = {
              CursorLine = { bg = '#0D0C0C' },
              CursorLineNr = { fg = '#C8C093', bg = '#282727' },
            },
          },
        },

        modes = {
          -- normal
          n = {
            winhl = {
              CursorLine = { bg = '#212121' },
              CursorLineNr = { fg = '#8BA4B0', bg = '#282727' },
            },
          },

          -- insert
          i = {
            winhl = {
              CursorLine = { bg = '#2D3622' },
              CursorLineNr = { fg = '#98BB6C', bg = '#282727' },
            },
          },

          -- visual
          [{ 'v', 'V', '\x16' }] = {
            winhl = {
              CursorLineNr = { fg = '#8992A7', bg = '#282727' },
            },
          },

          -- select
          [{ 's', 'S', '\x13' }] = {
            winhl = {
              CursorLineNr = { fg = '#8992A7', bg = '#282727' },
            },
          },

          -- replace
          R = {
            winhl = {
              CursorLine = { bg = '#453429' },
              CursorLineNr = { fg = '#B6927B', bg = '#282727' },
            },
          },

          -- command
          c = {
            winhl = {
              CursorLine = { bg = '#4A2A28' },
              CursorLineNr = { fg = '#C4746E', bg = '#282727' },
            },
          },

          -- operator pending
          no = {
            operators = {
              -- change
              c = {
                winhl = {
                  CursorLine = { bg = '#3C334A' },
                  CursorLineNr = { fg = '#957FB8', bg = '#282727' },
                },
              },

              -- delete
              d = {
                winhl = {
                  CursorLine = { bg = '#421617' },
                  CursorLineNr = { fg = '#C34043', bg = '#282727' },
                },
              },

              -- yank
              y = {
                winhl = {
                  CursorLine = { bg = '#5C3814' },
                  CursorLineNr = { fg = '#FF9E3B', bg = '#282727' },
                },
              },

              -- change case
              [{ 'gu', 'gU', 'g~', '~' }] = {
                winhl = {
                  CursorLine = { bg = '#40262E' },
                  CursorLineNr = { fg = '#D27E99', bg = '#282727' },
                },
              },
            },
          },
        },
      })
    end,
  },
}
