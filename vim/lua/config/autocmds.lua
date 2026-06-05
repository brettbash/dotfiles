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

-- On TabEnter, run the command PowerModeDisable and then PowerModeEnable to reset the power mode particles
vim.api.nvim_create_autocmd("TabEnter", {
  callback = function()
    -- Your command here
    -- print("Entered a tab!")
    -- vim.cmd("PowerModeDisable")
    -- vim.cmd("PowerModeEnable")
    -- if not pcall(vim.cmd, "PowerModeToggle") then
    --   print("Failed to execute PowerModeToggle")
    -- end
    -- fire a shortcut of <leader>pp to toggle power mode
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>pp", true, false, true), "n", true)
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

-- BufRead and set a fold for every indentation level
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup("set_folds"),
  callback = function()
    vim.opt.foldmethod = "manual"
  end,
})

-- Re-detect indentation for all buffers after session restore
vim.api.nvim_create_autocmd("SessionLoadPost", {
  group = augroup("session_indent_fix"),
  callback = function()
    vim.schedule(function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if
          vim.api.nvim_buf_is_valid(buf)
          and vim.api.nvim_buf_is_loaded(buf)
          and vim.bo[buf].buflisted
          and vim.bo[buf].buftype == ""
        then
          vim.api.nvim_buf_call(buf, function()
            vim.cmd("silent! GuessIndent silent")
          end)
        end
      end
    end)
  end,
})

vim.api.nvim_create_autocmd({ "WinNew", "WinClosed" }, {
  group = augroup("equalize_windows"),
  callback = function()
    vim.schedule(function()
      vim.cmd("wincmd =")
    end)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local uri = vim.uri_from_bufnr(buf)
    -- Skip non-file buffers (dashboard, oil, fugitive, etc.) to prevent "unknown scheme" errors
    if not uri:match("^file:/") then
      return
    end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.documentHighlightProvider = false
    end
  end,
})
