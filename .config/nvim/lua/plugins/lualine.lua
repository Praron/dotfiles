return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    { 'AndreM222/copilot-lualine' },
  },
  opts = {
    options = {
      icons_enabled = false,
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = string.lower,
          -- separator = { left = '' },
        },
      },
      lualine_b = {
        {
          'branch',
        },
        {
          'diff',
          colored = false,
        },
        {
          'filename',
          file_status = true,
          newfile_status = false,
          path = 1,
          shorting_target = 40,
          symbols = {
            modified = '[+]',
            readonly = '[-]',
            unnamed = '[No Name]',
            newfile = '[New]',
          },
          separator = { right = '' },
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        {
          'copilot',
          'diagnostics',
          separator = { left = '' },
          draw_empty = true,
        },
      },
      lualine_z = {
        {
          function()
            if vim.fn.winwidth(0) < 86 then
              return ''
            end
            local current_line = string.format('%3d', vim.fn.line('.'))
            local max_line = string.format('%3d', vim.fn.line('$'))
            local col = vim.fn.virtcol('.')
            local lineinfo = current_line .. '/' .. max_line .. ':' .. col
            return lineinfo
          end,
          -- separator = { right = '' },
        },
      },
    },
  },
  config = function(_, opts)
    local custom_theme = require('lualine.themes.auto')
    local colors = require('tokyonight.colors').setup({ transform = true })
    custom_theme.normal.c.bg = colors.bg
    opts.options.theme = custom_theme
    require('lualine').setup(opts)
  end,
}
