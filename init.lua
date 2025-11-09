require 'options'
require 'keymaps'

vim.o.termguicolors = true

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('s3mme-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Install Lazy Plugimanager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Configure and install plugins
require('lazy').setup({
  require 'plugins.sleuth', -- Detect tabstop and shiftwidth automatically
  require 'plugins.telescope', -- Fuzzy Search
  require 'plugins.conform', -- Autoformat
  require 'plugins.color', -- Colorscheme
  require 'plugins.todo-comments', -- Highlight TODO/NOTE/FIXME etc in code
  require 'plugins.treesitter',
  require 'plugins.indent_line', -- displays indentation guides
  require 'plugins.autopairs', -- matches open brackets
  require 'plugins.neo-tree', -- tree file system
  require 'plugins.gitsigns', -- git plugin
  require 'plugins.which-key', -- display info while pressing keys
  require 'plugins.obsidian', -- obsidian x nvim companion
  require 'plugins.zen-mode', -- sometimes you need to focus
  require 'plugins.pastify', -- paste images into markdown
  require 'plugins.lazygit', -- lazygit integration
  require 'plugins.alpha', -- dashboard
  require 'plugins.mason', -- Package Manager for Parsers, LSPs etc.
  require 'plugins.lsp', -- Configure LSPs
  require 'plugins.nvim-cmp', -- Autocomplete plugin, also included in lsp.lua as a dependency. Take out?
  require 'plugins.lualine', -- Autocomplete plugin, also included in lsp.lua as a dependency. Take out?
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

require 'autocmds'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
