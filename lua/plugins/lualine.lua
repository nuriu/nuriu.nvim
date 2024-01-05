return {
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
  },
  config = function()
    require('lualine').setup {
      sections = {
        lualine_a = { 'mode' },
        lualine_c = { { 'filename', path = 3 } },
        lualine_d = { 'diagnostics' },
      },
    }
  end,
}
