return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>fm',
      function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- List of available filetypes for selection
        local filetypes = {
          'bash',
          'c',
          'cpp',
          'golang',
          'css',
          'html',
          'json',
          'yaml',
          'markdown',
          'lua',
          'python',
          'xml',
        }

        -- Always ask the user to pick a filetype from the list
        vim.ui.select(filetypes, { prompt = 'Select filetype:' }, function(choice)
          if choice then
            -- Set the filetype based on user selection
            vim.bo[bufnr].filetype = choice
            vim.notify('Filetype set to: ' .. choice)

            -- Format the buffer based on the selected filetype
            require('conform').format {
              lsp_fallback = lsp_fallback,
              async = async,
              bufnr = bufnr,
              timeout_ms = formatting_timeout,
            }
          else
            vim.notify('No filetype selected. Aborting formatting.', vim.log.levels.WARN)
          end
        end)
      end,
      desc = 'Format file with filetype selection',
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      bash = { 'beautysh' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      tex = { 'latexindent' },
      yaml = { 'prettier' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      xml = { 'xmlformatter' },
      markdown = { 'prettier' },
      json = { 'jq' },
    },
    format_on_save = function(bufnr)
      --local disable_filetypes = { c = true, cpp = true }
      local disable_filetypes = {}
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
  },
}
