return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      keymap = { preset = 'enter' },
      appearance = { nerd_font_variant = 'normal' },
      completion = { documentation = { auto_show = false } },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    },
  },
}
