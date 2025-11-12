return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    {
      '<leader>tt',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Toggle Diagnostics',
    },
    {
      '<leader>tX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>tL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>tQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
  config = function()
    require('trouble').setup {}

    vim.keymap.set('n', '[t', function()
      require('trouble').next { skip_groups = true, jump = true }
    end)

    vim.keymap.set('n', ']t', function()
      require('trouble').previous { skip_groups = true, jump = true }
    end)
  end,
}
