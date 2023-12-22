require('globals')

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
KEYMAP.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
KEYMAP.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
KEYMAP.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
KEYMAP.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
KEYMAP.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
KEYMAP.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
KEYMAP.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Clear search highlights
KEYMAP.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Select all
KEYMAP.set('n', '<c-a>', 'ggVG')
