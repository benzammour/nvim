local function createNoteWithDefaultTemplate()
  local TEMPLATE_FILENAME = 'Template - Basic Note'
  local obsidian = require('obsidian').get_client()
  local utils = require 'obsidian.util'

  -- prompt for note title
  -- @see: borrowed from obsidian.command.new
  local note
  local title = utils.input 'Enter title or path (optional): '
  if not title then
    return
  elseif title == '' then
    title = nil
  end

  note = obsidian:create_note { title = title, no_write = true }

  if not note then
    return
  end
  obsidian:open_note(note, { sync = true })
  -- NOTE: make sure the template folder is configured in Obsidian.nvim opts
  obsidian:write_note_to_buffer(note, { template = TEMPLATE_FILENAME })
end

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
  vim.keymap.set('n', '<leader>on', createNoteWithDefaultTemplate, { desc = '[N]ew Obsidian [N]ote' }),
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Vault',
      },
    },
    -- Optional, for templates (see below).
    log_level = vim.log.levels.WARN,
    new_notes_location = 'notes_subdir',
    preferred_link_style = 'wiki',
    disable_frontmatter = false,

    notes_subdir = '00-Inbox',
    templates = {
      folder = '_templates/obsidian-app',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      substitutions = {},
    },

    -- Customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      if title ~= nil then
        return string.gsub(' ' .. title, '%W%l', string.upper):sub(2):gsub(' ', '_') .. '-' .. os.date '%Y%m%d%H%M%S'
      else
        error('Enter a Title', vim.log.levels.ERROR)
      end
    end,

    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix '.md'
    end,

    -- Optional, customize how wiki links are formatted. You can set this to one of:
    --  * "use_alias_only", e.g. '[[Foo Bar]]'
    --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
    --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
    --  * "use_path_only", e.g. '[[foo-bar.md]]'
    -- Or you can set it to a function that takes a table of options and returns a string, like this:
    --wiki_link_func = function(opts)
    --  return require('obsidian.util').wiki_link_id_prefix(opts)
    --end,

    -- Optional, customize how markdown links are formatted.
    --markdown_link_func = function(opts)
    --  return require('obsidian.util').markdown_link(opts)
    --end,

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      note:add_alias(note.id)

      local todays_date = (function()
        return os.date '%Y-%m-%d'
      end)()

      local out = { title = note.id, aliases = note.aliases, tags = note.tags, ['creation date'] = todays_date }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    follow_url_func = function(url)
      --vim.fn.jobstart { 'xdg-open', url } -- linux
      vim.ui.open(url) -- need Neovim 0.10.0+
    end,

    ---@param img string
    follow_img_func = function(img)
      vim.fn.jobstart { 'xdg-open', img } -- linux
    end,
  },
}
