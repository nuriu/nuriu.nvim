require('globals')

-- [[ Setting options ]]

-- Set highlight on search
OPT.hlsearch = true
OPT.incsearch = true

-- Make relative line numbers default
OPT.number = true
OPT.relativenumber = true

-- Enable mouse mode
OPT.mouse:append('a')

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
OPT.clipboard:append('unnamedplus')

-- Enable break indent
OPT.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
OPT.ignorecase = true
OPT.smartcase = true

-- Keep signcolumn on by default
OPT.signcolumn = 'yes'

-- Decrease update time
OPT.updatetime = 250
OPT.timeoutlen = 300

-- Set completeopt to have a better completion experience
OPT.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
OPT.termguicolors = true

-- Highlight line that cursor is at
OPT.cursorline = true

-- Set minimum lines to show
OPT.scrolloff = 10
OPT.sidescrolloff = 10

-- Don't use swap file
OPT.swapfile = false

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
