return {
  "nvim-telekasten/calendar-vim",
  config = function()
    vim.keymap.del("n", "<leader>caL")
    vim.keymap.del("n", "<leader>cal")
    -- vim.keymap.set("n", "<leader>ccv", "<cmd>CalendarT<cr>", { desc = "Calendar Veritcal" })
  end,
}
