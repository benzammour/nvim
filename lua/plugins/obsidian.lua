return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Vault/',
      },
    },
  },
  -- Optional, for templates (see below).
  templates = {
    folder = 'z_Templates',
    date_format = '%Y-%m-%d',
    time_format = '%H:%M',
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },
}
