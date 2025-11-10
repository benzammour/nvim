return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    local list = harpoon:list()

    harpoon.setup {
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = { 'harpoon' },
      },
    }

    -- Key mappings for Harpoon

    -- Add file to Harpoon
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to Harpoon' })

    -- Toggle Harpoon menu
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle Harpoon menu' })

    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end)

    -- Harpoon file X
    vim.keymap.set('n', '<M-1>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<M-2>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<M-3>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<M-4>', function()
      harpoon:list():select(4)
    end)
  end,
}
