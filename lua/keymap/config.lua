local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.smart_tab = function()
  local cmp = require('cmp')
  local ok, luasnip = pcall(require, 'luasnip')
  local luasnip_expandable = false
  local luasnip_jumpable = false
  if ok then
    luasnip_expandable = luasnip.expandable()
    luasnip_jumpable = luasnip.expand_or_jumpable()
  end
  if cmp.visible() and not luasnip_expandable then
    return '<C-n>'
  elseif luasnip_jumpable then
    return '<Plug>luasnip-expand-or-jump'
  elseif has_words_before() then
    return cmp.complete()
  else
    return '<Tab>'
  end
end

_G.smart_shift_tab = function()
  local cmp = require('cmp')
  local _, luasnip = pcall(require, 'luasnip')

  if cmp.visible() then
    return '<C-p>'
  elseif luasnip.jumpable(-1) then
    return "<cmd>lua require'luasnip'.jump(-1)<CR>"
  else
    return '<S-Tab>'
  end
end

-- luasnip cycle through choice nodes
_G.next_choice = function()
  local ok, luasnip = pcall(require, 'luasnip')
  if ok and luasnip.choice_active() then
    return '<Plug>luasnip-next-choice'
  else
    return '<C-l>'
  end
end

_G.prev_choice = function()
  local ok, luasnip = pcall(require, 'luasnip')
  if ok and luasnip.choice_active() then
    return '<Plug>luasnip-prev-choice'
  else
    return '<C-h>'
  end
end

-- vim.ui.select for choice nodes
_G.select_choice = function()
  local ok, luasnip = pcall(require, 'luasnip')
  if not ok or not luasnip.choice_active() then
    return '<C-u>'
  end
  if not packer_plugins['telescope.nvim'].loaded then
    vim.cmd([[packadd telescope.nvim]])
    vim.cmd([[packadd plenary.nvim]])
    vim.cmd([[packad dressing.nvim]])
  end

  return '<cmd>lua require("luasnip.extras.select_choice")()<CR>'
end

-- smatr q to quit in different conditions
_G.smart_q = function()
  local filetype = vim.bo.filetype
  if filetype == 'TelescopePrompt' then
    return '<Esc>'
  end

  local tabpage_num = #vim.api.nvim_list_wins()
  if (tabpage_num > 1) then
    return '<C-w>'
  end

  return '<cmd>q<CR>'
end

