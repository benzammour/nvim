local autocmd = vim.api.nvim_create_autocmd
autocmd('VimEnter', {
  pattern = '*',
  command = 'silent! cd %:p:h',
})

-- Highlight when yanking
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('s3mme-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- LSP options
autocmd('LspAttach', {
  callback = function(e)
    vim.keymap.set('n', 'gd', function()
      vim.lsp.buf.definition()
    end, { buffer = e.buf, desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover()
    end, { buffer = e.buf, desc = 'Get Documentation' })
    vim.keymap.set('n', '<leader>cws', function()
      vim.lsp.buf.workspace_symbol()
    end, { buffer = e.buf, desc = 'Current Workspace Symbol' })
    vim.keymap.set('n', '<leader>cd', function()
      vim.diagnostic.open_float()
    end, { buffer = e.buf, desc = 'Open Float' })
    vim.keymap.set('n', '<leader>cca', function()
      vim.lsp.buf.code_action()
    end, { buffer = e.buf, desc = 'Code Action' })
    vim.keymap.set('n', '<leader>crr', function()
      vim.lsp.buf.references()
    end, { buffer = e.buf, desc = 'References' })
    vim.keymap.set('n', '<leader>crn', function()
      vim.lsp.buf.rename()
    end, { buffer = e.buf, desc = 'Rename Current Symbol' })
    vim.keymap.set('i', '<C-g>', function()
      vim.lsp.buf.signature_help()
    end, { buffer = e.buf, desc = 'Signature Help' })
    vim.keymap.set('n', '[d', function()
      vim.diagnostic.goto_next()
    end, { buffer = e.buf, desc = 'Goto Next diagnostic' })
    vim.keymap.set('n', ']d', function()
      vim.diagnostic.goto_prev()
    end, { buffer = e.buf, desc = 'Goto Previous diagnostic' })

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'References', nowait = true })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation', nowait = true })
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto T[y]pe Definition', nowait = true })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration', nowait = true })
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})
