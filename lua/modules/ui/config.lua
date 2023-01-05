local config = {}

function config.gruvbox()
  require('gruvbox').setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
  })
  vim.cmd('colorscheme gruvbox')
end

function config.zephyr()
  vim.cmd('colorscheme zephyr')
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
    }
  })
end

function config.galaxyline()
  require('modules.ui.eviline')
end

function config.lspsaga()
  local saga = require('lspsaga')
  saga.init_lsp_saga({
    finder_request_timeout = 1500,
    border_style = "rounded",
    symbol_in_winbar = {
      in_custom = true,
      enable = false,
      show_file = true,
    },
    show_outline = {
      win_width = 40,
    }
  })
  require('modules.ui.winbar')
end

function config.dressing()
  require('dressing').setup({
    select = {
      enabled = true,
      backend = { 'telescope' },
      trim_prompt = true,
      telescope = require('telescope.themes').get_cursor()
    }
  })
end

function config.dashboard()
  local db = require('dashboard')
  local z = require('zephyr')
  local home = string.gsub(tostring(os.getenv('LOCALAPPDATA')), '\\', '/')
  db.session_directory = home .. '/nvim-data/session'
  db.preview_command = 'pwsh --noprofile -Command type'
  db.preview_file_path = home .. '/nvim/static/neovim.cat'
  db.preview_file_height = 11
  db.preview_file_width = 70
  db.custom_center = {
    {
      icon = '  ',
      icon_hl = { fg = z.red },
      desc = 'Update Plugins                          ',
      shortcut = 'SPC p u',
      action = 'PackerUpdate',
    },
    {
      icon = '  ',
      icon_hl = { fg = z.yellow },
      desc = 'Recently opened files                   ',
      action = 'Telescope oldfiles',
      shortcut = 'SPC f o',
    },
    {
      icon = '  ',
      icon_hl = { fg = z.cyan },
      desc = 'Find File                               ',
      action = 'Telescope find_files',
      shortcut = 'SPC f f',
    },
    {
      icon = '  ',
      icon_hl = { fg = z.blue },
      desc = 'File Browser                            ',
      action = 'Telescope file_browser',
      shortcut = 'SPC   e',
    },
    {
      icon = '  ',
      icon_hl = { fg = z.oragne },
      desc = 'Find word                               ',
      action = 'Telescope live_grep',
      shortcut = 'SPC f l',
    },
  }
end

function config.indent_blankline()
  require('indent_blankline').setup({
    use_treesitter_scope = true,
    show_first_indent_level = true,
    show_current_context = false,
    show_current_context_start = false,
    show_current_context_start_on_current_line = false,
  })
end

return config
