-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.diagnostic.enable(false)
opt.tabstop = 4
opt.shiftwidth = 4 -- Size of an indent
opt.softtabstop = 4
opt.wrap = false -- Line wrap
opt.linebreak = true
opt.foldmethod = "expr"
vim.g.lazyvim_picker = "fzf"

vim.opt_local.spelllang = "en_us"
vim.opt_local.fo:append("aw")

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
