local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local c = require("luasnip.extras.conditions.expand")
local parse_snippet = ls.parser.parse_snippet
local t = ls.text_node
local line_begin = c.line_begin
local utils = require("luasnip-latex-snippets.util.utils")
local is_math = utils.with_opts(utils.is_math, true) -- true to use treesitter
local not_math = utils.with_opts(utils.not_math, true) -- true to use treesitter

-- Environment snippets
local snippets = {
  parse_snippet(
    { trig = "mk", name = "Math", snippetType = "autosnippet", condition = utils.pipe({ not_math }), priority = 10 },
    "$${1:${TM_SELECTED_TEXT}}$$0"
  ),
  parse_snippet(
    { trig = "dm", name = "Block Math", snippetType = "autosnippet", condition = not_math, priority = 10 },
    "\\[\n\t${1:${TM_SELECTED_TEXT}}\n.\\] $0"
  ),

  s(
    { trig = "ali", name = "Align", snippetType = "autosnippet" },
    { t({ "\\begin{align*}", "\t" }), i(1), t({ "", ".\\end{align*}" }) }
  ),
  parse_snippet(
    { trig = "beg", name = "begin{} / end{}", snippetType = "autosnippet" },
    "\\begin{$1}\n\t$0\n\\end{$1}"
  ),

  s(
    { trig = "theorem", condition = line_begin },
    fmt(
      [[
\begin{{theorem}}[{}]
{}
\end{{theorem}}{}]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "proof", condition = line_begin },
    fmt(
      [[
\begin{{proof}}
{}
\end{{proof}}{}]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "soln", condition = line_begin },
    fmt(
      [[
\begin{{soln}}
{}
\end{{soln}}{}]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ex", condition = line_begin },
    fmt(
      [[
\begin{{example}}[{}]
{}
\end{{example}}{}]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "gat", condition = line_begin },
    fmt(
      [[
\begin{{gather*}}
{}
\end{{gather*}}{}]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ans", condition = line_begin },
    fmt(
      [[
\begin{{answer}}
{}
\end{{answer}}{}]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "rem", snippetType = "autosnippet", condition = line_begin },
    fmt(
      [[
\begin{{remark}}~    
{}
\end{{remark}}]],
      { i(0) }
    )
  ),

  s(
    { trig = "prop", condition = line_begin },
    fmt(
      [[
\begin{{proposition}}~    
{}
\end{{proposition}}]],
      { i(0) }
    )
  ),

  s(
    { trig = "eq", condition = line_begin },
    fmt(
      [[
\begin{{equation}}
\label{{eq:{}}}
{}
\end{{equation}}{}]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "def", condition = line_begin },
    fmt(
      [[
\begin{{definition}}[{}]
{}
\end{{definition}}{}]],
      { i(1), i(2), i(0) }
    )
  ),

  parse_snippet(
    { trig = "notes", name = "notes template", condition = line_begin },
    [[
\\documentclass[11pt, oneside]{scrbook}
\\usepackage{tweedz}
\\usepackage{theorems}
%\\usepackage{qs}
\\usepackage{toc}

\\title{\Huge{${1:Module Code}}\\\
${2:Module Title}}
\\author{\huge{Tom Tweedy}}

\\begin{document}

\\maketitle
\\tableofcontents
\\pagebreak

$0
\end{document}
    ]]
  ),
  parse_snippet(
    { trig = "assign", name = "assignment template", condition = line_begin },
    [[
\documentclass[12pt,a4paper]{scrartcl}
\usepackage{titling}
\usepackage{pdfpages} %\includepdf{}

\usepackage{tweedz}
\usepackage{theorems}
\usepackage{qs}
%\usepackage{toc}

\setlength{\droptitle}{-3cm}
\setlength{\marginparwidth}{2cm}

\title{\Huge{${1:Module Code}}\\\ ${2:Assignment 1}}
\date{\today}
\author{\huge{Tom Tweedy}}

\begin{document}
\maketitle

$0
\end{document}
    ]]
  ),

  parse_snippet({ trig = "pac", name = "usepackage override", condition = line_begin }, "\\usepackage{${1:package}}$0"),

  parse_snippet(
    { trig = "sec", name = "section", condition = line_begin },
    [[
\section{$1}
$0
    ]]
  ),

  parse_snippet(
    { trig = "sub", name = "subsection", condition = line_begin },
    [[
\subsection{$1}
$0
    ]]
  ),

  parse_snippet(
    { trig = "item", name = "itemize", condition = line_begin, snippetType = "autosnippet" },
    [[
\begin{itemize}
	\item $0
\end{itemize}
    ]]
  ),

  parse_snippet(
    { trig = "enum", name = "enumerate", condition = line_begin, snippetType = "autosnippet" },
    [[
\begin{enumerate}
	\item $0
\end{enumerate}
    ]]
  ),

  parse_snippet(
    { trig = "fig", name = "figure", condition = line_begin },
    [[
\begin{figure}[htpb]
	\centering
	\includegraphics[width=0.8\textwidth]{$3}
\end{figure}
  ]]
  ),

  s(
    { trig = "table", dscr = "LaTeX Table with dynamic column alignment" },
    fmt(
      [[
\begin{table}[<1>]
	\centering
	\caption{<2>}
	\label{tab:<3>}
	\begin{tabular}{<4>}
	<5>
	\end{tabular}
\end{table}
  ]],
      {
        i(1, "htpb"),
        i(2, "caption"),
        i(3, "label"),
        i(4, "c"),
        ls.f(function(args)
          local str = args[1][1] or ""
          local letters = str:gsub("[^clr]", "")
          return #letters > 1 and string.rep(" & ", #letters - 1) or ""
        end, { 4 }),
      },
      {
        delimiters = "<>",
      }
    ),
    { condition = line_begin }
  ),
  --   parse_snippet(
  --     { trig = "table", name = "table", condition = line_begin },
  --     [[
  -- \begin{table}[${1:htpb}]
  -- 	\centering
  -- 	\caption{${2:caption}}
  -- 	\label{tab:${3:label}}
  -- 	\begin{tabular}{${5:c}}
  -- 	$0${5/((?<=.)c|l|r)|./(?1: & )/g}
  -- 	\end{tabular}
  -- \end{table}
  -- ]]
  --   ),
}

-- Add the snippets to LuaSnip for "tex" filetype
ls.add_snippets("tex", snippets)
