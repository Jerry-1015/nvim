---------------------------------------------
-- @author          Jerry
-- @create          2022/12/24 0:14:34
-- @last modified   2022/12/28 21:19:34
---------------------------------------------

-- add search path
package.path = package.path .. ";" .. vim.fn.stdpath('config') .. '/snippets/?.lua'

-- basic init
local ls = require("helper")
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.d
local c = ls.c
local f = ls.f
local sn = ls.sn

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local cs = ls.cs
local ac = ls.ac

-- don't work if remove
ls.snippets = {}
ls.autosnippets = {}

ls.group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
ls.file_pattern = "*.lua"

-- auto update time
local function auto_update_time()
  for line = 1, vim.api.nvim_buf_line_count(0), 1 do
    if vim.api.nvim_buf_get_lines(0, line - 1, line,
      true)[1]:match("^-- @last modified") then
      vim.api.nvim_buf_set_lines(0, line - 1, line, true, { '-- @last modified   ' .. os.date() })
      break
    end
  end
end

ac("BufWritePre", auto_update_time)

cs("local", fmt([[
  local {} = {}
]], {
  i(1, ""),
  i(2, ""),
}))

cs("info", fmt([[
---------------------------------------------
-- @author          Jerry
-- @create          {}
-- @last modified   {}
---------------------------------------------
]], {
  f(function()
    return os.date()
  end),
  f(function()
    return os.date()
  end),
}), { auto = true })

return ls.snippets, ls.autosnippets
