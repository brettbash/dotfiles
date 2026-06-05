-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║  🔄 MOVE                                                                   ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

vim.keymap.set("n", "<leader>mj", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<leader>mk", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("v", "<leader>mj", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<leader>mk", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
