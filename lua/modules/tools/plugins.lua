local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

-- telescop
plugin({
  'nvim-telescope/telescope.nvim',
  tag = '0.1.0',
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim', opt = true },
  },
})

-- nvim-tree
plugin({ 'nvim-tree/nvim-tree.lua', cmd = 'NvimTreeToggle', config = conf.nvim_tree })


