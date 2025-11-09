-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>ll', '<cmd>Lazy<cr>', { desc = 'Open Lazy Package Manager Menu' })

-- Copy the current file's directory to clipboard
vim.keymap.set('n', '<leader>yp', function()
  local file_dir = vim.fn.expand '%:p:h'
  if file_dir ~= '' then
    vim.fn.setreg('+', file_dir) -- Copies the directory path to the clipboard
    vim.notify 'File path copied to clipboard.'
  else
    vim.notify('No file is currently focused.', vim.log.levels.WARN)
  end
end, { desc = "Copy the current file's directory to clipboard" })

-- Function to format JSON in the current buffer
vim.keymap.set('v', '<leader>jf', function()
  local start_pos = vim.api.nvim_buf_get_mark(0, '<')
  local end_pos = vim.api.nvim_buf_get_mark(0, '>')
  local text = vim.api.nvim_buf_get_lines(0, start_pos[1] - 1, end_pos[1], false)

  local joined_text = table.concat(text, '\n')

  local success, parsed = pcall(vim.fn.json_decode, joined_text)
  if not success then
    vim.notify('Invalid JSON detected, could not format', vim.log.levels.ERROR)
    return
  end

  local pretty_json = vim.fn.json_encode(parsed)

  -- json_encode produces compact json, so we reformat for pretty printing
  pretty_json = vim.fn.system("jq '.'", pretty_json)

  vim.api.nvim_buf_set_lines(0, start_pos[1] - 1, end_pos[1], false, vim.split(pretty_json, '\n'))
end, { noremap = true, silent = true, desc = "Format JSON in the current buffer."})
