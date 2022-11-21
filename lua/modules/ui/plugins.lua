local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

-- theme
-- plugin({ 'ellisonleao/gruvbox.nvim', config = conf.gruvbox })
plugin({ 'glepnir/zephyr-nvim', config = conf.zephyr })


-- bufferline
plugin({ 'akinsho/nvim-bufferline.lua', tag = "v3.*", config = conf.nvim_bufferline, requires = 'nvim-tree/nvim-web-devicons' })

-- statusline
plugin({ 'glepnir/galaxyline.nvim',
  branch = 'main',
  config = conf.galaxyline,
  requires = 'nvim-tree/nvim-web-devicons',
})

