return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup({
      options = {
        diagnostics = 'nvim_lsp',
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'Explorer',
            text_align = 'center',
            separator = true
          },
          {
            filetype = 'sagaoutline',
            text = 'Outline',
            text_align = 'center',
            separator = true
          }
        },
        get_element_icon = function(element)
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        separator_style = 'slope', -- 'slant' | 'slope' | 'thick' | 'thin'
      }
    })
  end
}
