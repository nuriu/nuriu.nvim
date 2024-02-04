require('globals')

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

-- Enable break indent (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
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

-- Better splitting
OPT.splitbelow = true
OPT.splitright = true

-- Enable the sign column to prevent the screen from jumping
OPT.signcolumn = 'yes'

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
OPT.foldcolumn = '0'
OPT.foldlevel = 99
OPT.foldlevelstart = 99
OPT.foldenable = true

-- Place a vertical column
OPT.colorcolumn = '80,120'

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

-- Set shell to PowerShell 7 if on Win32 or Win64
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
  OPT.shell = 'pwsh -NoLogo'
  OPT.shellcmdflag =
    '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  OPT.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
  OPT.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  OPT.shellquote = ''
  OPT.shellxquote = ''
end

OPT.guicursor = {
  'n-v-c:block', -- Normal, visual, command-line: block cursor
  'i-ci-ve:ver25', -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
  'r-cr:hor20', -- Replace, command-line replace: horizontal bar cursor with 20% height
  'o:hor50', -- Operator-pending: horizontal bar cursor with 50% height
  'a:blinkwait700-blinkoff400-blinkon250', -- All modes: blinking settings
  'sm:block-blinkwait175-blinkoff150-blinkon175', -- Showmatch: block cursor with specific blinking settings
}
