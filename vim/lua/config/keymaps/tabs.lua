-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║  🗂️  TABS  //  Tab Switching with Sound                                    ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

vim.keymap.set({ "n", "v" }, "U", "<cmd>redo<cr>", { desc = "Redo" })

vim.keymap.set("n", "<leader><tab>[", function()
  vim.cmd("tabprevious")
  require("beepboop").play("flipOpen")
end, { desc = "Previous Tab" })

vim.keymap.set("n", "<leader><tab>]", function()
  vim.cmd("tabnext")
  require("beepboop").play("flipOpen")
end, { desc = "Next Tab" })
