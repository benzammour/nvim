return {
  'TobinPalmer/pastify.nvim',
  cmd = { 'Pastify', 'PastifyAfter' },
  config = function()
    require('pastify').setup {
      opts = {
        absolute_path = false, -- use absolute or relative path to the working directory
        apikey = '',
        local_path = function()
          return vim.fn.expand '%:h' .. '/assets'
        end,
        save = 'local',
        filename = function()
          return vim.fn.expand '%:t:r' .. '_' .. os.date '%Y-%m-%d_%H-%M-%S'
        end,
        -- Example result: 'file_2021-08-01_12-00-00'
        default_ft = 'markdown', -- Default filetype to use
      },
      ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
        html = '<img src="$IMG$" alt="">',
        markdown = '![]($IMG$)',
        tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
        css = 'background-image: url("$IMG$");',
        js = 'const img = new Image(); img.src = "$IMG$";',
        xml = '<image src="$IMG$" />',
        php = '<?php echo "<img src="$IMG$" alt="">"; ?>',
        python = '# $IMG$',
        java = '// $IMG$',
        c = '// $IMG$',
        cpp = '// $IMG$',
        swift = '// $IMG$',
        kotlin = '// $IMG$',
        go = '// $IMG$',
        typescript = '// $IMG$',
        ruby = '# $IMG$',
        vhdl = '-- $IMG$',
        verilog = '// $IMG$',
        systemverilog = '// $IMG$',
        lua = '-- $IMG$',
      },
    }
  end,
}
