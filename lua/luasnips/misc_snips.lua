local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local c = require("luasnip.extras.conditions.expand")
local parse_snippet = ls.parser.parse_snippet
local t = ls.text_node
local line_begin = c.line_begin

local snippets = {
  -- item
  parse_snippet({ trig = "i", name = "item", condition = line_begin }, "\\item "),

  -- colours
  parse_snippet({ trig = "red", name = "red italics" }, [[\emph{\color{RubineRed} $1} $0]]),
  parse_snippet({ trig = "blue", name = "blue italics" }, [[\emph{\color{RoyalBlue} $1} $0]]),
  parse_snippet({ trig = "green", name = "green italics" }, [[\emph{\color{green} $1} $0]]),
  parse_snippet({ trig = "al", name = "alert", condition = line_begin }, "\\alert{$1}$0"),

  -- italic text
  parse_snippet({ trig = "it", name = "italics" }, [[\emph{$1}$0]]),
  parse_snippet({ trig = "bgin", name = "fix begin", snippetType = "autosnippet" }, "begin"),
  parse_snippet({ trig = "^th", snippetType = "autosnippet", wordTrig = false }, "$^\\text{th}$$0"),
}

ls.add_snippets("tex", snippets)
