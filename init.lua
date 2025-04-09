require 'options'
require 'keymaps'
require 'autocmds'

vim.o.termguicolors = true

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
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
  require 'plugins.lazydev', -- LSP Plugins
  require 'plugins.nvim-cmp', -- Autocomplete
  require 'plugins.conform', -- Autoformat
  require 'plugins.catppuccin', -- Colorscheme
  require 'plugins.todo-comments', -- Highlight TODO/NOTE/FIXME etc in code
  require 'plugins.mini',
  require 'plugins.treesitter',
  require 'plugins.dap-debug',
  require 'plugins.indent_line',
  require 'plugins.lint',
  require 'plugins.autopairs',
  require 'plugins.neo-tree',
  require 'plugins.gitsigns',
  require 'plugins.which-key',
  require 'plugins.obsidian',
  require 'plugins.render-markdown',
  require 'plugins.vim-markdown',
  require 'plugins.zen-mode',
  require 'plugins.pastify',
  require 'plugins.lazygit',
  require 'plugins.multicursors',
  require 'plugins.alpha',
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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
