local keymap = require('core.keymap')
local nmap, imap, cmap, tmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.tmap
local silent, noremap, remap = keymap.silent, keymap.noremap, keymap.remap
local expr = keymap.expr
local opts = keymap.new_opts
local cmd = keymap.cmd

require('keymap.config')

-- Use space as leader key
vim.g.mapleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
nmap({ ' ', '', opts(noremap) })

-- noremal remap
nmap({
  -- close buffer
  { '<C-w>', cmd('bdelete') },
  -- save
  { '<C-s>', cmd('write') },
  -- quit
  { 'q', _G.smart_q, opts(expr, remap) },
  { 'Q', cmd('q!') },
  -- buffer jump
  { ']b', cmd('bn') },
  { '[b', cmd('bp') },
  -- remove trailing white space
  { '<Leader>t', cmd('TrimTrailingWhitespace') },
  -- window jump
  { '<C-h>', '<C-w>h' },
  { '<C-l>', '<C-w>l' },
  { '<C-j>', '<C-w>j' },
  { '<C-k>', '<C-w>k' },
  { '<C-[>', '<C-w>r' },
  { '<C-]>', '<C-w>R' },
  { '<C-x>', '<C-w>x' },
  -- resize window
  { '<A-[>', cmd('vertical resize -5') },
  { '<A-]>', cmd('vertical resize +5') },
  { '<A-,>', cmd('resize -5') },
  { '<A-.>', cmd('resize +5') },
})

-- insertmode remap
imap({
  -- turn to normal mode
  { 'jk', '<ESC>', opts(noremap) },
  -- insert mode
  { '<C-j>', '<Esc>o' },
  { '<C-k>', '<Esc>O' },
  { '<C-a>', '<Esc>^i' },
  { '<C-s>', '<ESC>:w<CR>' },
  {
    '<C-e>',
    function()
      return vim.fn.pumvisible() == 1 and '<C-e>' or '<End>'
    end,
    opts(expr),
  },
})

-- commandline remap
cmap({
  { '<C-b>', '<Left>' },
  { '<C-f>', '<Right>' },
  { '<C-a>', '<Home>' },
  { '<C-e>', '<End>' },
  { '<C-d>', '<Del>' },
  { '<C-h>', '<BS>' },
})

tmap({ '<Esc>', [[<C-\><C-n>]] })
