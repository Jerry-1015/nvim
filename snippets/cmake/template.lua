---------------------------------------------
-- @author          Jerry
-- @create          2022/12/24 0:14:34
-- @last modified   2023/1/9 14:21:12
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

ls.group = vim.api.nvim_create_augroup("CMake Snippets", { clear = true })
ls.file_pattern = "CMakeLists.txt"

-- main project template
cs('project', fmt([[
# set minimum cmake version
cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

# set CXX compiler
set(CMAKE_CXX_COMPILER clang++)
# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_OBJCXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
# generate compiler_command.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# set build type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# print custom message
message("***********************************************")
message("** CMAKE_CXX_COMPILER is: ${{CMAKE_CXX_COMPILER}}")
message("** CMAKE_CXX_STANDARD is: ${{CMAKE_CXX_STANDARD}}")
message("** CMAKE_BUILD_TYPE is: ${{CMAKE_BUILD_TYPE}}")
message("***********************************************")

# project name and language
project({} LANGUAGES CXX)

# set subdirectory
add_subdirectory({})

# main code
add_executable(main)
target_sources(main PRIVATE {})
target_include_directories(main PUBLIC {})

# set run target
add_custom_target(run COMMAND $<TARGET_FILE:main>)

# enable test
enable_testing()
add_subdirectory(test)

]], {
  i(1, 'project name'),
  i(2, 'sources'),
  i(3, 'sub_dir'),
  i(4, 'inc_dir'),
}))

-- test template
cs('test module', fmt([[
# use google test
find_package(GTest REQUIRED)

# macro test
macro(add_custom_test _test_name)
  add_executable(${{_test_name}}_test ${{_test_name}}.cpp)
  target_include_directories(${{_test_name}}_test PUBLIC {})
  target_link_libraries(${{_test_name}}_test PRIVATE GTest::GTest)

  add_test(
    NAME unit_tests_${{_test_name}}
    COMMAND
    $<TARGET_FILE:${{_test_name}}_test>
    )
endmacro()

add_custom_test({}){}
]], {
  i(1, 'inc_dir'),
  i(2, 'test_name'),
  i(0),
}))

return ls.snippets, ls.autosnippets

