-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb"
  end,
})

-- VIMTEX CONFIG --

-- options to compile faster
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_fold_enabled = 0

vim.g.vimtex_view_skim_sync = 0
vim.g.vimtex_view_skim_activate = 0

vim.g.vimtex_compiler_latexmk = {
  -- compile latex docs into build folder
  out_dir = "build",
  options = {
    "-shell-escape",
    "-interaction=nonstopmode",
    "-file-line-error",
    "-synctex=1",
    "-silent",
  },
}
