return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      local custom_kanagawa = require('lualine.themes.kanagawa')
      custom_kanagawa.normal.b.bg = '#181616'

      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = custom_kanagawa,
          section_separators = '',
          component_separators = '',
          disabled_filetypes = { 'dashboard' },
        },

        sections = {
          lualine_a = {
            {
              'mode',
              fmt = string.lower,
            }
          },

          lualine_b = {
            {
              'branch',
              icon = '',
            },
            'diff',
            'diagnostics',
          },

          lualine_c = {
            {
              'filename',
              file_status = true,
              newfile_status = true,
              path = 3,
            }
          },

          lualine_x = {
            {
              'filetype',
              colored = false,
            },
            'encoding',
            'fileformat',
          },

          lualine_y = {
            {
              'progress',
              fmt = string.lower,
            }
          },

          lualine_z = {
            {
              'location',
              padding = { right = 1, },
            },
          },
        },

        globalstatus = true,

        extensions = { 'neo-tree', 'lazy', 'mason' },
      })
    end,
  },
}
