require("globals")

-- [[ Setting options ]]

-- Set highlight on search
opt.hlsearch = true
opt.incsearch = true

-- Make relative line numbers default
opt.number = true
opt.relativenumber = true

-- Enable mouse mode
opt.mouse:append 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard:append 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
opt.termguicolors = true

-- Highlight line that cursor is at
opt.cursorline = true

-- Set minimum lines to show
opt.scrolloff = 10
opt.sidescrolloff = 10

-- Don't use swap file
opt.swapfile = false

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
