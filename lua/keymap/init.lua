require('keymap.remap')
local keymap = require('core.keymap')
local nmap, imap, xmap, tmap = keymap.nmap, keymap.imap, keymap.xmap, keymap.tmap
local silent, noremap = keymap.silent, keymap.noremap
local expr, remap = keymap.expr, keymap.remap
local opts = keymap.new_opts
local cmd = keymap.cmd
require('keymap.config')


imap({
  -- tab key
  { '<TAB>', _G.smart_tab, opts(expr, remap) },
  { '<S-TAB>', _G.smart_shift_tab, opts(expr, remap) },
})

-- usage of plugins
nmap({
  -- packer
  { '<Leader>pu', cmd('PackerUpdate'), opts(noremap, silent) },
  { '<Leader>pi', cmd('PackerInstall'), opts(noremap, silent) },
  { '<Leader>pc', cmd('PackerCompile'), opts(noremap, silent) },
  -- Lsp
  { '<Leader>li', cmd('LspInfo') },
  { '<Leader>ll', cmd('LspInfo') },
  { '<Leader>lr', cmd('LspInfo') },
  -- dashboard
  { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
  { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
  { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
  -- nvimtree
  { '<Leader>e', cmd('NvimTreeToggle'), opts(noremap, silent) },
  -- Telescope
  { '<Leader>b', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<Leader>fa', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
})
