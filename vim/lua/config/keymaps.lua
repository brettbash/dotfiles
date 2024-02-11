-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<F1>", "5b", { desc = "Word Back Fast" })
vim.keymap.set({ "n", "v" }, "<F2>", "5j", { desc = "Down Fast" })
vim.keymap.set({ "n", "v" }, "<F3>", "5k", { desc = "Up Fast" })
vim.keymap.set({ "n", "v" }, "<F4>", "5w", { desc = "Word Forward Fast" })

vim.keymap.set(
  { "n", "v" },
  "<F12>",
  "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<cr>",
  { desc = "Oil" }
)

vim.keymap.set(
  { "n", "v" },
  "<F11>",
  "<cmd>lua require('mini.files').open(vim.loop.cwd(), true)<cr>",
  { desc = "Oil CWD" }
)

vim.keymap.set(
  { "n", "v" },
  "<tab>",
  "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
  { desc = "Telescope Buffers" }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>gb",
  "<cmd>Gitsigns toggle_current_line_blame<cr>",
  { desc = "Git Blame Current Line" }
)

vim.keymap.set({ "n", "v" }, "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Git Preview Hunk" })

vim.keymap.set({ "n", "v" }, "U", "<cmd>redo<cr>", { desc = "Redo" })

--
-- highlights = {
--     fill = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     background = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     tab = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     tab_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     tab_separator = {
--       fg = '<colour-value-here>',
--       bg = '<colour-value-here>',
--     },
--     tab_separator_selected = {
--       fg = '<colour-value-here>',
--       bg = '<colour-value-here>',
--       sp = '<colour-value-here>',
--       underline = '<colour-value-here>',
--     },
--     tab_close = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     close_button = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     close_button_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     close_button_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     buffer_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     buffer_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     numbers = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     numbers_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     numbers_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     diagnostic = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     diagnostic_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     diagnostic_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     hint = {
--         fg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     hint_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     hint_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     hint_diagnostic = {
--         fg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     hint_diagnostic_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     hint_diagnostic_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     info = {
--         fg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     info_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     info_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     info_diagnostic = {
--         fg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     info_diagnostic_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     info_diagnostic_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     warning = {
--         fg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     warning_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     warning_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     warning_diagnostic = {
--         fg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     warning_diagnostic_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     warning_diagnostic_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     error = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--     },
--     error_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     error_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     error_diagnostic = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--     },
--     error_diagnostic_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     error_diagnostic_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         sp = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     modified = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     modified_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     modified_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     duplicate_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         italic = true,
--     },
--     duplicate_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         italic = true,
--     },
--     duplicate = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         italic = true,
--     },
--     separator_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     separator_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     separator = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     indicator_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     indicator_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     pick_selected = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     pick_visible = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     pick = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--         bold = true,
--         italic = true,
--     },
--     offset_separator = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     },
--     trunc_marker = {
--         fg = '<colour-value-here>',
--         bg = '<colour-value-here>',
--     }
--
