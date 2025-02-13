vim.keymap.set({ "n", "v" }, "<F1>", "5b", { desc = "Word Back Fast" })
vim.keymap.set({ "n", "v" }, "<F2>", "5j", { desc = "Down Fast" })
vim.keymap.set({ "n", "v" }, "<F3>", "5k", { desc = "Up Fast" })
vim.keymap.set({ "n", "v" }, "<F4>", "5w", { desc = "Word Forward Fast" })

vim.keymap.set(
  { "n", "v" },
  "<tab>",
  "<cmd>lua require('fzf-lua').buffers()<cr><cmd>lua require('beepboop').play_audio('klink')<cr>",
  { desc = "Browse Buffers" }
)
vim.keymap.set({ "n", "v" }, "U", "<cmd>redo<cr>", { desc = "Redo" })
vim.keymap.set({ "n", "v" }, "<leader>bo", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer" })
