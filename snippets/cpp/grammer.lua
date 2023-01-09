---------------------------------------------
-- @author          Jerry
-- @create          2023/1/3 18:07:16
-- @last modified   2023/1/9 10:25:54
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
-- for snip
cs({ trig = 'for([0-9a-zA-Z_]+)', regTrig = true }, fmt([[
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

-- if esle snip
cs("if", fmt([[
if ({}) {{
  {}
}}{}
]],
{
  i(1),
  i(2),
  i(0),
}))

cs("else", fmt([[
else {{
  {}
}}{}
]],
{
  i(1),
  i(0),
}))

cs("else if", fmt([[
else if ({}) {{
  {}
}}{}
]],
{
  i(1),
  i(2),
  i(0),
}))

-- type ; then add it to the end automatically
local auto_add_comma = function()
vim.keymap.set('i', ';', function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local cur_line = vim.api.nvim_get_current_line()
    local len = string.len(cur_line)

    local last_words = vim.api.nvim_buf_get_text(0, row - 1,
      col, row - 1, len, {})[1]

    local match_words = last_words:match('^[%)}]+')

    if match_words ~= nil then
      vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, len,
      { match_words .. ';' })
      vim.api.nvim_win_set_cursor(0, { row, len + 1 })
    else
      vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { ';' })
      vim.api.nvim_win_set_cursor(0, { row, col + 1 })
    end
  end, { silent = true, nowait = true, buffer = true })
end

ac('FileType', auto_add_comma, { pattern = 'cpp' })

return ls.snippets, ls.autosnippets
