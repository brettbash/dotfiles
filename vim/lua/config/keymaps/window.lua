local focal_pane = require("config.focal-pane")

focal_pane.setup({
  percent = 10,
  auto_expand = true,
})

-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║  📐 WINDOW RESIZE  //  Toggle percentage expansion of active pane          ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

vim.keymap.set("n", "<leader>w=", function()
  focal_pane.toggle_width()
end, { desc = "Resize Width (toggle % expand)" })
