local plugin = require('core.pack').register_plugin
local conf = require('modules.completion.config')

plugin({
  'neovim/nvim-lspconfig',
  -- used filetype to lazyloa lsp
  -- config your language filetype in here
  ft = { 'lua', 'rust', 'c', 'cpp', 'cmake', 'python' },
  config = conf.nvim_lsp,
})

-- plugin({ 'williamboman/mason.nvim', config = conf.mason })
-- plugin({ 'williamboman/mason-lspconfig.nvim', config = conf.mason_lspconfig })

plugin({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.nvim_cmp,
  requires = {
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
  },
})

plugin({ 'L3MON4D3/LuaSnip', event = 'InsertCharPre', config = conf.lua_snip })

plugin({ 'windwp/nvim-autopairs', event = 'InsertEnter', config = conf.auto_pairs })

plugin({ 'kylechui/nvim-surround', event = 'InsertEnter', tag = "*", config = conf.nvim_surround })

