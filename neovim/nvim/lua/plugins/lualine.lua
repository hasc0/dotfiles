return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = '',
        component_separators = '',
      },

      sections = {
        lualine_a = { { 'mode', fmt = string.lower } },
        lualine_b = { { 'branch', icon = '' }, 'diff', 'diagnostics' },
        lualine_c = { { 'filename', file_status = true, newfile_status = true, path = 3 } },
        lualine_x = { { 'filetype', colored = false }, 'encoding', 'fileformat' },
        lualine_y = { 'progress' },
        lualine_z = { { 'location', padding = { right = 1 } } },
      },

      globalstatus = true,

      extensions = { 'neo-tree', 'lazy', 'mason' },
    },
  },
}
