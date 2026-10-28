local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local parse = ls.parser.parse_snippet

local M = {}

function M.retrieve(is_math)
  -------------------------------------------------
  -- Helpers
  -------------------------------------------------

  local function autos(context, nodes)
    context.condition = is_math
    context.snippetType = "autosnippet"
    return s(context, nodes)
  end

  local function autos_parse(context, body)
    context.condition = is_math
    context.snippetType = "autosnippet"
    return parse(context, body)
  end

  local function reg_parse(context, body)
    context.condition = is_math
    return parse(context, body)
  end

  -------------------------------------------------
  -- Snippets
  -------------------------------------------------

  return {
    -- Vector
    autos(
      {
        trig = "(%a+)vec",
        regTrig = true,
        wordTrig = false,
        priority = 200,
      },
      f(function(_, snip)
        return "\\vec{" .. snip.captures[1] .. "}"
      end)
    ),

    autos_parse({ trig = "vec", priority = 100 }, "\\vec{$1}$0"),

    -- Hat vec
    autos(
      {
        trig = "(%a+)hav",
        regTrig = true,
        wordTrig = false,
        priority = 200,
        name = "hat vector",
      },
      f(function(_, snip)
        return "\\hat{\\mathbf{" .. snip.captures[1] .. "}}"
      end)
    ),

    autos_parse({ trig = "hav" }, "\\hat{\\mathbf{$1}}$0"),
    -- Tilde
    autos(
      {
        trig = "(%a+)til",
        regTrig = true,
        wordTrig = false,
      },
      f(function(_, snip)
        return "\\tilde{" .. snip.captures[1] .. "}"
      end)
    ),
    autos_parse({ trig = "til" }, "\\tilde{$1}$0"),

    -- Matrices
    autos_parse({ trig = "pmat" }, "\\begin{pmatrix} $1 \\end{pmatrix} $0"),

    autos_parse({ trig = "bmat" }, "\\begin{bmatrix} $1 \\end{bmatrix} $0"),

    autos_parse({ trig = "matrix" }, "\\begin{matrix} $1 \\end{matrix} $0"),

    -- Brackets
    reg_parse({ trig = "()" }, "\\left( ${1:${TM_SELECTED_TEXT}} \\right) $0"),

    reg_parse({ trig = "lr[]" }, "\\left[ ${1:${TM_SELECTED_TEXT}} \\right] $0"),

    -- Derivatives
    autos_parse({ trig = "ddx" }, "\\frac{d ${1}}{dx}$0"),

    autos_parse({ trig = "der" }, "\\frac{d ${1}}{d ${2}}$0"),

    autos_parse({ trig = "ddt" }, "\\frac{d ${1}}{dt}$0"),

    autos_parse({ trig = "par" }, "\\frac{\\partial ${1}}{\\partial ${2}}$0"),

    autos_parse({ trig = "pl" }, "\\partial"),

    autos_parse({ trig = "dydx" }, "\\frac{dy}{dx}$0"),
    -- Sum, prod
    autos_parse({ trig = "sum", wordTrig = true }, "\\sum_{${1:i=1}}^{${2:\\infty}} ${3:a_n z^n}"),
    autos_parse({ trig = "prod" }, "\\prod_{${1:i=1}}^{${2:n}} ${3}"),

    -- Misc
    reg_parse({ trig = "xi" }, "\\xi "),
    reg_parse({ trig = "tf" }, "\\therefore"),
    reg_parse({ trig = "q" }, "\\quad"),
    reg_parse({ trig = "qq" }, "\\qquad"),
    autos_parse({ trig = "2pi", name = "2pi" }, "2\\pi"),
    autos_parse({ trig = "ww", name = "omega" }, "\\omega "),

    -- integrals
    autos_parse({ trig = "_{i}i" }, "\\iint"), -- overriding i subscript
    autos_parse({ trig = "\\iinti" }, "\\iiint"),

    -- determinant
    reg_parse({ trig = "det" }, "\\left| \\begin{matrix} $1 \\end{matrix} \\right| $0"),

    -- Piecewise
    autos_parse(
      { trig = "pce" },
      [[
\begin{cases}
$1 & \text{if } x $2, \\
$3 & \text{if } x $4. \\
\end{cases}
]]
    ),

    -- Greek
    autos_parse({ trig = "al" }, "\\alpha"),
    autos_parse({ trig = "eps" }, "\\epsilon"),
    autos_parse({ trig = "vareps" }, "\\varepsilon"),

    -- Subscripts
    autos_parse({ trig = "ann" }, "a_{n}"),
    autos_parse({ trig = "ajj" }, "a_{j}"),

    -- exp
    autos_parse({ trig = "ee" }, "e^{$1}$0"),

    -- grad
    autos_parse({ trig = "grad" }, "\\nabla "),

    -- underbrace
    autos_parse({ trig = "und" }, "\\underbrace{$1}_{$2}$0"),

    -- overset
    autos_parse({ trig = "over" }, "\\overset{${1:text}}{${2:object}}$0"),

    -- cvec
    autos_parse(
      { trig = "cvc", name = "column vector" },
      [[\\begin{pmatrix} ${1:x}_${2:1} \\\ \\vdots \\\ $1_n\\end{pmatrix}]]
    ),

    -- set
    autos_parse({ trig = "set", priority = 200 }, [[\Set{$1}$0]]),

    -- rightarrow
    autos_parse({ trig = "-->", name = "overset arrow", priority = 210 }, "\\overset{$1}{\\longrightarrow}$0"),

    -- approx
    autos_parse({ trig = "app", name = "approx" }, "\\approx"),

    -- i subscript
    autos_parse({ trig = "ii", wordTrig = false }, "_{i}$0"),

    -- n subscript
    autos_parse({ trig = "nn", wordTrig = false, priority = 10 }, "_{n}$0"),

    -- bigcap override
    autos_parse({ trig = "_{n}n", name = "bigcap" }, "\\bigcap_{${1:i \\in ${2: I}}} $0"),

    -- inn override
    autos_parse({ trig = "inn", name = "in", wordTrig = false, priority = 200 }, "\\in "),

    -- subset equals
    autos_parse({ trig = "subseq", name = "subseteq", wordTrig = true }, "\\subseteq"),
  }
end

return M
