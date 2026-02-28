-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Disable wrap and enable spell check for text files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.spell = true
  end,
})

-- Diagnostics float on CursorHold
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--   group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
--   callback = function()
--     vim.diagnostic.open_float(nil, {
--       focus = false,
--       border = "rounded",
--     })
--   end,
-- })

-- Disable diagnostics for .env files
local group = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env",
  group = group,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})

-- Force filetype to html for *.antlers.html files
local force_filetype = vim.api.nvim_create_augroup("force_filetype", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.antlers.html" },
  group = force_filetype,
  callback = function()
    vim.opt.filetype = "html"
  end,
})

-- If filetype is yaml or json, set the indent to 2 spaces
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "yaml", "json", "markdown", "lua" },
  group = force_filetype,
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
  end,
})

-- BufRead and set a fold for every indentation level
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup("set_folds"),
  callback = function()
    vim.opt.foldmethod = "manual"
  end,
})
