local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

-- theme
plugin({ 'ellisonleao/gruvbox.nvim', config = conf.gruvbox })

-- bufferline
plugin({ 'akinsho/nvim-bufferline.lua', tag = "v3.*", config = conf.nvim_bufferline, requires = 'kyazdani42/nvim-web-devicons' })
