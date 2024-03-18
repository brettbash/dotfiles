vim.keymap.set({ "n", "v" }, "<F1>", "5b", { desc = "Word Back Fast" })
vim.keymap.set({ "n", "v" }, "<F2>", "5j", { desc = "Down Fast" })
vim.keymap.set({ "n", "v" }, "<F3>", "5k", { desc = "Up Fast" })
vim.keymap.set({ "n", "v" }, "<F4>", "5w", { desc = "Word Forward Fast" })

vim.keymap.set(
  { "n", "v" },
  "<F16>",
  "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<cr>",
  { desc = "Oil" }
)

vim.keymap.set(
  { "n", "v" },
  "<F13>",
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
