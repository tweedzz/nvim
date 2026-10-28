return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    event = { "InsertEnter" }, -- "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "uga-rosa/cmp-dictionary",
    },
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Only enable in tex files
      opts.enabled = function()
        return vim.bo.filetype == "tex"
      end

      -- Only Enter confirms
      opts.mapping = {
        ["<CR>"] = cmp.mapping.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
        }),
      }

      -- Only dictionary + buffer words
      opts.sources = {
        { name = "dictionary" },
        { name = "buffer" },
      }

      return opts
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- Dictionary setup
      --require("cmp_dictionary").setup({
      --  dic = {
      --    tex = { "/usr/share/dict/web2" }, -- change if needed
      --  },
      --})
      require("cmp_dictionary").setup({
        paths = { "/usr/share/dict/web2" },
        exact_length = 2,
      })

      -- Command line completion
      --cmp.setup.cmdline(":", {
      --  mapping = {
      --    ["<CR>"] = cmp.mapping.confirm({ select = true }),
      --  },
      --  sources = {
      --    { name = "cmdline" },
      --  },
      --})
    end,
  },
}
