---------------------------------------------
-- @author          Jerry
-- @create          2022/12/24 0:14:34
-- @last modified   2023/1/6 14:46:47
---------------------------------------------

local ls = {}

local luasnip = require("luasnip")
ls.s = luasnip.s --> snippet
ls.i = luasnip.i --> insert node
ls.t = luasnip.t --> text node

ls.d = luasnip.dynamic_node
ls.c = luasnip.choice_node
ls.r = luasnip.restore_node
ls.f = luasnip.function_node
ls.sn = luasnip.snippet_node

ls.fmt = require('luasnip.extras.fmt').fmt
ls.rep = require('luasnip.extras').rep

ls.snippets = {}
ls.autosnippets = {}

ls.group = vim.api.nvim_create_augroup("All Snippets", { clear = true })
ls.file_pattern = "*"

-- custom snippet
ls.cs = function(trigger, nodes, opts)
  local snippet = nil
  if opts ~= nil and opts.snip_opts then
    snippet = ls.s(trigger, nodes, opts.snip_opts)
  else
    snippet = ls.s(trigger, nodes)
  end

  local target_table = ls.snippets
  local pattern = ls.file_pattern
  local group = ls.group
  local keymaps = {}

  -- check for custom pattern
  if opts ~= nil and opts.pattern then
    pattern = opts.pattern
  end

  -- check for custom augroup
  if opts ~= nil and opts.group then
    group = opts.group
  end

  -- check for snippetType
  if opts ~= nil and opts.auto then
    target_table = ls.autosnippets
  end

  -- check for keymaps
  if opts ~= nil and opts.keymap then
    for _, keymap in ipairs(opts.keymap) do
      if type(keymap) == "string" then
        table.insert(keymaps, { "i", keymap })
      else
        table.insert(keymaps, keymap)
      end
    end
  end

  -- set autocmd for each keymap
  for _, keymap in ipairs(keymaps) do
    vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" },
    {
      pattern = pattern,
      group = group,
      callback = function()
        vim.keymap.set(keymap[1], keymap[2],
        function()
          ls.snip_expand(snippet)
        end,
        { normap = true, silent = true, buffer = true })
      end
    })
  end

  table.insert(target_table, snippet)
end

-- autocmds
ls.ac = function(event, fn, opts)
  local pattern = ls.file_pattern
  local group = ls.group
  if opts ~= nil and opts.pattern then
    pattern = opts.pattern
  end

  if opts ~= nil and opts.group then
    group = opts.group
  end

  vim.api.nvim_create_autocmd(event, {
      pattern = pattern,
      group = group,
      callback = fn
    })
end

return ls
