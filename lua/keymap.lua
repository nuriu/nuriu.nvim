require('globals')

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
KEYMAP.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
KEYMAP.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
KEYMAP.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Clear search highlights
KEYMAP.set('n', '<leader>nh', '<cmd>nohl<cr>', { desc = 'Clear search highlights' })

-- Select all
KEYMAP.set('n', '<c-a>', 'ggVG')

-- Move between buffers
KEYMAP.set('n', '<c-n>', '<cmd>bnext<cr>')
KEYMAP.set('n', '<c-p>', '<cmd>bprevious<cr> ')