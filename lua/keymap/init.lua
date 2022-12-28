require('keymap.remap')
local keymap = require('core.keymap')
local nmap, imap, xmap, tmap, smap = keymap.nmap, keymap.imap, keymap.xmap, keymap.tmap, keymap.smap
local silent, noremap = keymap.silent, keymap.noremap
local expr, remap = keymap.expr, keymap.remap
local opts = keymap.new_opts
local cmd = keymap.cmd
require('keymap.config')

imap({
  -- tab key
  { '<TAB>', _G.smart_tab, opts(expr, remap) },
  { '<S-TAB>', _G.smart_shift_tab, opts(expr, remap) },
  -- luasnip cycle through choice nodes
  { '<C-h>', _G.prev_choice, opts(expr, remap) },
  { '<C-l>', _G.next_choice, opts(expr, remap) },
  -- luasnip select choice
  { '<C-u>', _G.select_choice, opts(expr, remap) },
})

smap({
  -- tab key
  { '<TAB>', _G.smart_tab, opts(expr, remap) },
  { '<S-TAB>', _G.smart_shift_tab, opts(expr, remap) },
  -- luasnip cycle through choice nodes
  { '<C-h>', _G.prev_choice, opts(expr, remap) },
  { '<C-l>', _G.next_choice, opts(expr, remap) },
})

-- usage of plugins
nmap({
  -- packer
  { '<Leader>pu', cmd('PackerUpdate'), opts(noremap, silent) },
  { '<Leader>pi', cmd('PackerInstall'), opts(noremap, silent) },
  { '<Leader>pc', cmd('PackerCompile'), opts(noremap, silent) },
  -- Lsp
  { '<Leader>li', cmd('LspInfo') },
  { '<Leader>ll', cmd('LspLog') },
  { '<Leader>lr', cmd('LspRestart') },
  -- Lspsaga
  { '[e', cmd('Lspsaga diagnostic_jump_next') },
  { ']e', cmd('Lspsaga diagnostic_jump_prev') },
  { '[c', cmd('Lspsaga show_cursor_diagnostics') },
  { '[l', cmd('Lspsaga show_line_diagnostics') },
  { 'K', cmd('Lspsaga hover_doc') },
  { 'ga', cmd('Lspsaga code_action') },
  { 'gd', cmd('Lspsaga peek_definition') },
  { 'gr', cmd('Lspsaga rename') },
  { 'gh', cmd('Lspsaga lsp_finder') },
  { '<Leader>o', cmd('Lspsaga outline') },
  { '<Leader>g', cmd('Lspsaga open_floaterm pwsh') },
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

tmap({
  -- Lspsaga floaterm
  { '<Leader>g', [[<C-\><C-n>:Lspsaga close_floaterm<CR>]] }
})
