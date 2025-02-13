-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true }) -- disable autowrap in Markdown

local force_filetype = vim.api.nvim_create_augroup("force_filetype", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.antlers.html" },
  group = force_filetype,
  callback = function()
    vim.bo.filetype = "html"
  end,
})
