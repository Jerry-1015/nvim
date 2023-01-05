local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

-- telescop
plugin({
  'nvim-telescope/telescope.nvim',
  tag = '0.1.0',
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    { 'nvim-lua/plenary.nvim', opt = true },
    { 'nvim-telescope/telescope-fzy-native.nvim', opt = true },
    { 'nvim-telescope/telescope-file-browser.nvim', opt = true },
  },
})

plugin({ 'phaazon/hop.nvim', event = 'BufRead', config = conf.hop })

-- plugin({ 'nvim-telescope/telescope-ui-select.nvim' })



