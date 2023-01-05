---------------------------------------------
-- @author          Jerry
-- @create          2023/1/3 18:07:16
-- @last modified   2023/1/5 22:35:40
---------------------------------------------

package.path = package.path .. ";" .. vim.fn.stdpath('config') .. '/snippets/?.lua'

local ls = require("utils")
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.d
local c = ls.c
local f = ls.f
local r = ls.r
local sn = ls.sn

local fmt =ls.fmt
local rep = ls.rep

local cs = ls.cs
local ac = ls.ac

-- don't work, if remove
ls.snippets, ls.autosnippets = {}, {}

ls.group = vim.api.nvim_create_augroup("Cpp Snippets", { clear = true })
ls.file_pattern = { '*.cpp', '*.hpp', '*.h', '*.cc' }

----- grammer -----
local test = s({ trig = 'doc(%d)', regTrig = true }, {
  f(function(_, snip)
    return string.rep("repeatme ", tonumber(snip.captures[1]))
  end, {})
})

cs({ trig = 'for([0-9a-zA-Z_]+)', regTrig = true, docTrig = 'fori' }, fmt([[
for (int {} = {}; {} < {}; ++{}) {{
  {}
}}{}
]],
{
  d(1, function(_, snip) return sn(1, i(1, snip.captures[1])) end),
  i(2, '0'),
  rep(1),
  i(3, 'size'),
  rep(1),
  i(4, "// TODO:"),
  i(0),
}))

return ls.snippets, ls.autosnippets
