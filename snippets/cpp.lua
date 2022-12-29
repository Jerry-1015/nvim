---------------------------------------------
-- @author          Jerry
-- @create          2022/12/24 0:14:34
-- @last modified   2022/12/28 22:03:06
---------------------------------------------

package.path = package.path .. ";" .. vim.fn.stdpath('config') .. '/snippets/?.lua'

local ls = require("helper")
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

----- doxygen -----
-- mainpage
cs('dmp ', fmt([[
/*******************************************************************************
* @mainpage     {}
* <table>
* <tr><th>Project   <td>{}
* <tr><th>Author    <td>{}
* <tr><th>Date      <td>{}
* </table>
* @section    Project Detailed Description
* {}
*******************************************************************************/

{}
]],
{
  i(1, "title"),
  i(2, "project name"),
  i(3, "author name"),
  f(function()
    return os.date()
  end),
  i(4, "detail"),
  i(0),
}), { auto = true })
-- file
cs('dfp ', fmt([[
/*******************************************************************************
* @file         {}
* @brief        {}
* @author       {}
* @email        {}
* @date         {}
* @modified     {}
* @version      {}
* @copyright    Copyright (c) {}
********************************************************************************
* @attention
* {}
*******************************************************************************/

{}
]],
{
  i(1, 'file name'),
  i(2, 'A short Description'),
  i(3, 'author name'),
  i(4, 'email'),
  f(function() return os.date() end),
  f(function() return os.date() end),
  i(5, 'version'),
  i(6, 'copyright'),
  i(7, 'attention'),
  i(0),
}), { auto = true })

-- if modified, update time
local function auto_update_time()
  for line = 1, vim.api.nvim_buf_line_count(0), 1 do
    if vim.api.nvim_buf_get_lines(0, line - 1, line,
      true)[1]:match("* @modified     ") then
      vim.api.nvim_buf_set_lines(0, line - 1, line, true, { '* @modified     ' .. os.date() })
      break
    end
  end
end

ac("BufWritePre", auto_update_time)
-- function
local function fn(args)
  local nodes = {
    t({ "/**", "* @brief " }),
    r(1, 'desc', i(1, "A short Description")),
    t({ '', '' }),
  }

  local insert = 2
  -- At least one param
  for _, arg in ipairs(vim.split(args[1][1], ",", true)) do
    -- trim
    arg = string.gsub(arg, "^%s*(.-)%s*$", "%1")
    -- Get actual name parameter
    arg = vim.split(arg, " ", true)[2]
    if arg then
      local rnode = r(insert, "arg" .. arg, i(1))
      vim.list_extend(nodes, { t('* param ' .. arg .. ' '), rnode, t({ '', '' }) })

      insert = insert + 1
    end
  end


  vim.list_extend(nodes, { t('* @return '), r(insert, 'ret', i(1)), t({ '', '*/' }) })
  return sn(nil, nodes)
end

-- declare function
cs({ trig = 'd([0-9a-zA-Z_]+)f ', regTrig = true, wordTrig = false }, fmt([[
{}
{} {}({}){};

{}
]], {
  d(4, fn, 2),
  f(function(_, snip) return snip.captures[1] end),
  i(1, ''),
  i(2, ''),
  c(3, {
    t(''),
    t(' const'),
    t(' override'),
    t(' = delete'),
    t(' = default'),
    t(' &'),
    t(' &&'),
    t(' const &'), }),
  i(0),
}), { auto = true })

-- define function
cs({ trig = '([0-9a-zA-Z_]+)fn ', regTrig = true, wordTrig = false }, fmt([[
{} {}({}) {}{{
  {}
}}

{}
]], {
  f(function(_, snip) return snip.captures[1] end),
  i(1, ''),
  i(2, ''),
  c(3, {
    t(''),
    t('const '),
    t('override '),
    t('& '),
    t('&& '),
    t('const & ') }),
  i(4, '// TODO:'),
  i(0),
}), { auto = true })

-- class
cs('cs ', fmt([[
/**
* @brief {}
*/
class {} {{
{}
  {}
}};

{}
]],
{
  i(1),
  i(2),
  c(3, { t('public:'), t('protected:'), t('private:') }),
  i(4, '// TODO:'),
  i(0),
}), { auto = true })

-- struct
cs('st ', fmt([[
/**
* @brief {}
*/
struct {} {{
  {}
}};

{}
]],
{
  i(1),
  i(2),
  i(3, '// TODO:'),
  i(0),
}), { auto = true })

-- variable comment
cs('vc ', fmt([[
/**<  {}  */
{}
]],
{
  i(1),
  i(0),
}), { auto = true })

-- check if in comment env
local is_comment_env = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local content = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  content = content:sub(0, col - 2)
  if content:match('^%* $') ~= nil then
    return true
  else
    return false
  end
end

cs({ trig = "de" },
  { t("@detail "), i(1) },
  { snip_opt = { condition = is_comment_env }, auto = true })

return ls.snippets, ls.autosnippets
