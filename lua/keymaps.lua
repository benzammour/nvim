local keymap = vim.keymap

-- Clear highlights on search when pressing <Esc> in normal mode
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable Arrow Keys
keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  Use CTRL+<hjkl> to switch between windows
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keymap.set('n', '<leader>ll', '<cmd>Lazy<cr>', { desc = 'Open Lazy Package Manager Menu' })

-- window management
keymap.set('n', '<leader>w|', '<C-w>v', { desc = 'Split window vertically' }) -- split window vertically
keymap.set('n', '<leader>w-', '<C-w>s', { desc = 'Split window horizontally' }) -- split window horizontally
keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
keymap.set('n', '<leader>wx', '<cmd>close<CR>', { desc = 'Close current split' }) -- close current split window

-- Resize window using <ctrl> arrow keys
keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- commenting
keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- move next/prev in quicklist
vim.keymap.set('n', '<M-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<M-j>', '<cmd>cprev<CR>zz')

-- move visually selected lines via J and K
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- keeps cursor where it is when moving the next line to current line
vim.keymap.set('n', 'J', 'mzJ`z')

-- keep cursor centered when half-page scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- restart LSP
vim.keymap.set('n', '<leader>zig', '<cmd>LspRestart<cr>')

-- ####################
-- # CUSTOM FUNCTIONS #
-- ####################

-- Copy the current file's directory to clipboard
keymap.set('n', '<leader>yp', function()
  local file_dir = vim.fn.expand '%:p:h'
  if file_dir ~= '' then
    vim.fn.setreg('+', file_dir) -- Copies the directory path to the clipboard
    vim.notify 'File path copied to clipboard.'
  else
    vim.notify('No file is currently focused.', vim.log.levels.WARN)
  end
end, { desc = "Copy the current file's directory to clipboard" })

-- Function to format JSON in the current buffer
keymap.set('v', '<leader>fj', function()
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
end, { noremap = true, silent = true, desc = 'Format JSON in the current buffer.' })
