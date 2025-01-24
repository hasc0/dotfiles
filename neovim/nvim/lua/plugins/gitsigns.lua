return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Git: Jump to Next Change' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Git: Jump to Previous Change' })

        -- actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Git: Stage Hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Git: Reset Hunk' })

        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git: Stage Hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git: Reset Hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git: Stage Buffer' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Git: Reset Buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git: Preview Hunk' })
        map('n', '<leader>hp', gitsigns.preview_hunk_inline, { desc = 'Git: Preview Hunk Inline' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'Git: Blame Line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git: Diff Against Index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'Git: Diff Against Last Commit' })

        -- toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Git: Toggle Show Blame Line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = 'Git: Toggle Show Deleted' })
      end,
    },
  },
}
