require('globals')

return {
  'fedepujol/move.nvim',
  config = function()
    local opts = { noremap = true, silent = true }
    -- Normal-mode commands
    KEYMAP.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
    KEYMAP.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)

    -- Visual-mode commands
    KEYMAP.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
    KEYMAP.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
  end,
}
