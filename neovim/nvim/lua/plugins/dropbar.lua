return {
  {
    'Bekaboo/dropbar.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },

    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Dropbar: Pick Symbols in Winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Dropbar: Goto Start of Current Context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Dropbar: Select Next Context' })
    end,
  },
}
