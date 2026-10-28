-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "<D-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap = true })
vim.keymap.set("i", "<C-backspace>", "<Esc>cvb", { noremap = true })
