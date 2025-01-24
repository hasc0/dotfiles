-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto Previous Diagnostic Message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto Next Diagnostic Message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Diagnostic Error Messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' })

-- shortcut to exit terminal mode in the builtin terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

-- keymaps to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus Left Window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus Right Window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus Lower Window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus Upper Window' })
