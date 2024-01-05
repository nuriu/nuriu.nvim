-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- lsp
  require('plugins.lspconfig'),

  -- Autocompletion
  require('plugins.cmp'),

  -- Useful plugin to show you pending keybinds.
  require('plugins.which-key'),

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  require('plugins.gitsigns'),

  -- Theme
  require('plugins.themes.onedark'),
  -- require('plugins.themes.gruvbox'),

  -- Set lualine as statusline
  require('plugins.lualine'),

  -- Cursor line
  require('plugins.cursorline'),

  -- Add indentation guides even on blank lines
  require('plugins.indent-blankline'),

  -- "gc" to comment visual regions/lines
  require('plugins.comment'),

  -- Fuzzy Finder (files, lsp, etc)
  require('plugins.telescope'),

  -- Highlight, edit, and navigate code
  require('plugins.treesitter'),

  -- Autoformat
  require('plugins.conform'),

  -- Autopairs
  require('plugins.autopairs'),

  -- Debugging
  require('plugins.dap'),

  -- Tree view
  require('plugins.tree'),

  -- Move line / block
  require('plugins.move'),

  -- Toggle terminal
  require('plugins.toggleterm'),
}, {})

require('base')
require('keymap')
