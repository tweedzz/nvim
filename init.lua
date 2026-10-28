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

-- Disable the slow parts of VimTeX
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_fold_enabled = 0

-- Stop VimTeX from trying to 'sync' with your viewer constantly
vim.g.vimtex_view_skim_sync = 0
vim.g.vimtex_view_skim_activate = 0

vim.g.vimtex_compiler_latexmk = {
  out_dir = "build",
  --out_dir = "",
  options = {
    "-shell-escape",
    "-interaction=nonstopmode",
    "-file-line-error",
    "-synctex=1",
    "-silent", -- Add this to reduce the amount of data written to the log
  },
}
