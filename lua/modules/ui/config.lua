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
  require('bufferline').setup({})
end

function config.galaxyline()
  require('modules.ui.eviline')
end

function config.lualine()
  require('lualine').setup()
end

function config.nvim_tree()
  require('nvim-tree').setup({
    disable_netrw = false,
    hijack_cursor = true,
    hijack_netrw = true,
  })
end

return config
