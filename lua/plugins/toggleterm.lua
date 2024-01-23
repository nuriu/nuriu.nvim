return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup({
      open_mapping = [[<c-\>]],
      start_in_insert = true,
      direction = 'float',
      float_opts = {
        border = 'curved',
        width = math.ceil(vim.o.columns * 0.8),
        height = math.ceil(vim.o.columns * 0.2),
      },
    })
  end,
}
