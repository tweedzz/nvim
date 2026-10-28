return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",

  config = function()
    require("luasnips.environments")
    require("luasnips.misc_snips")

    local ls = require("luasnip")

    ls.config.set_config({
      enable_autosnippets = true,
    })
    -------------------------------------------------
    -- VimTeX math condition
    -------------------------------------------------
    local function is_math()
      return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end

    -------------------------------------------------
    -- Load your custom tex snippets
    -------------------------------------------------
    ls.add_snippets("tex", require("luasnips.maths").retrieve(is_math))

    local M = {}

    function M.jump_next()
      if ls.jumpable(1) then
        ls.jump(1)
      end
    end

    function M.jump_prev()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end

    function M.change_choice()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end

    function M.reload_package(package_name)
      for module_name, _ in pairs(package.loaded) do
        if string.find(module_name, "^" .. package_name) then
          package.loaded[module_name] = nil
          require(module_name)
        end
      end
    end

    function M.refresh_snippets()
      ls.cleanup()
      M.reload_package("luasnips.snips")
      M.reload_package("luasnips.maths") -- reload your tex snippets too
    end

    -------------------------------------------------
    -- Keymaps
    -------------------------------------------------
    local set = vim.keymap.set
    local mode = { "i", "s" }
    local normal = { "n" }

    set(mode, "<D-k>", M.change_choice)
    set(normal, ",r", M.refresh_snippets)

    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        -- Fallback to regular tab if not in snippet
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
      end
    end, { silent = true })

    set({ "i", "s" }, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
        return ""
      else
        return "<S-Tab>"
      end
    end, { expr = true })
  end,
}
