return {
  -- Add the ayu plugin
  { "Shatur/neovim-ayu" },

  -- Configure LazyVim to use the 'ayu' colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
    },
  },
}
