---------------------------------------------
-- @author          Jerry
-- @create          2022/12/24 0:14:34
-- @last modified   2023/1/5 22:26:12
---------------------------------------------

-- add search path
package.path = package.path .. ";" .. vim.fn.stdpath('config') .. '/snippets/?.lua'

-- basic init
local ls = require("utils")
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

-- signature
cs({ trig = 'sign', desc = 'signature' }, t('Jerry'))

-- email
cs({ trig = 'email', desc = 'email' }, t('781467164@qq.com'))

return ls.snippets, ls.autosnippets

