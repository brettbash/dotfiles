-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
})
vim.diagnostic.enable(true)
opt.tabstop = 4
opt.shiftwidth = 4 -- Size of an indent
opt.softtabstop = 4
opt.wrap = false -- Line wrap
opt.linebreak = true
-- opt.foldmethod = "indent"
opt.foldmethod = "manual" -- Manual folding
opt.fillchars = {
  foldopen = ">",
  fold = ".",
  foldsep = " ",
  foldclose = "󱓇",
}
vim.g.lazyvim_picker = "fzf"

-- Make foldtext show the number of lines in the fold
-- opt.foldtext = "substitute(getline(v:foldstart), '^\\s*', '', '') . ' (' . (v:foldend - v:foldstart + 1) . ' lines)'"
-- Redo it but make the text keep the indention of the fold and have the total number of lines to be at the far right with a dotted line betweent them.
-- opt.foldtext =
--   "substitute(getline(v:foldstart), '^\\s*', '', '') . ' ' . repeat('.', 80 - (v:foldend - v:foldstart + 1)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)'"
-- Again, but really keep the indentation of the text to be where the folded content's indentation is.
-- Make the above a fucntion and easier to read
-- opt.foldtext = [[
--     function()
--         local start_line = v:foldstart
--         local end_line = v:foldend
--         local fold_text = substitute(getline(start_line), '^\\s*', '', '')
--         local indent = repeat(' ', indent(start_line))
--         local indent = string.rep(' ', vim.fn.indent(start_line))
--         local indent = repeat(' ', vim.fn.indent(start_line))
--         local num_lines = end_line - start_line + 1
--         return indent .. fold_text .. ' ' .. repeat('.', 80 - num_lines) .. ' (' .. num_lines .. ' lines)'
--     end
--  ]]

-- Disable folding by default
-- opt.foldenable = false
vim.opt_local.spelllang = "en_us"
vim.opt_local.fo:append("aw")

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
