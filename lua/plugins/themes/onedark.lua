return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('onedark')

    require('onedark').setup({
      -- style = 'dark',
      -- style = 'darker',
      -- style = 'cool',
      style = 'deep',
      -- style = 'warm',
      -- style = 'warmer',
    })

    require('onedark').load()
  end,
}
