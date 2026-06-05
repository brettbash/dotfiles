-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║  🔭 PICKERS  //  Snacks, Grep, Nvumi                                       ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

vim.keymap.set({ "n", "v" }, "<leader><leader>", function()
  Snacks.picker.files()
  require("beepboop").play("klink")
end, { desc = "Browse Files" })

vim.keymap.set("n", "<leader>/", function()
  require("snacks.picker").grep()
  require("beepboop").play("hitap")
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>on", "<CMD>Nvumi<CR>", { desc = "[O]pen [N]vumi" })
