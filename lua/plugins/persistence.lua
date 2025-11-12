return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  lazy = false,
  opts = {
    dir = vim.fn.stdpath 'state' .. '/sessions/',
    -- minimum number of file buffers that need to be open to save
    -- Set to 0 to always save
    need = 1,
    branch = true,
    hooks = {
      select = function()
        return require('telescope.builtin').find_files {
          cwd = require('persistence').get_dir(),
          prompt_title = 'Sessions',
        }
      end,
    },
  },
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'Load session for current directory',
    },
    {
      '<leader>qS',
      function()
        require('persistence').select()
      end,
      desc = 'Select session to load',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Load last session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = 'Stop persistence',
    },
  },
}
