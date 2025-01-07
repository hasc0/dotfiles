return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000, -- load first
    opts = {
      transparent = false,
      undercurl = true,

      -- this might do nothing currently?
      overrides = function(colors)
        local theme = colors.theme
        local makeDiagnosticColor = function(color)
          local c = require('kanagawa.lib.color')
          return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        return {
          DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
        }
      end,
    },

    config = function()
      require('kanagawa').load('dragon')
    end,
  },
}
