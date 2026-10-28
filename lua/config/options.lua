-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vimtex config
vim.g.tex_conceal = "abdmg"
vim.g.tex_flavor = "latex"

vim.g.vimtex_view_method = "skim"
vim.g.vimtex_view_skim_reading_bar = 1

-- vim.g.vimtex_compiler_method = "latexmk"
--
-- vim.g.vimtex_view_skim_sync = 0
-- vim.g.vimtex_view_skim_activate = 0

-- vim.g.vimtex_compiler_latexmk = {
--   -- aux_dir = "build.nosync",
--   out_dir = "build",
--   continuous = 0,
--   options = {
--     "-pdf",
--     "-pvc",
--     "-interaction=nonstopmode",
--     "-synctex=1",
--     "-file-line-error",
--   },
-- }
-- vim.g.vimtex_compiler_latexmk = {
--   out_dir = "build",
--   continuous = 1,
-- }

-- vim.g.vimtex_compiler_clean_on_terminate = 1 -- cleans files when closing vim

-- ultisnips config
vim.g.vimtex_imaps_enabled = 0
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

-- nvim-cmp config
vim.opt.pumheight = 5 -- limit completion items

-- blink.cmp config
vim.opt.termguicolors = true
