return {
  "eandrju/cellular-automaton.nvim",
  config = function()
    vim.keymap.set("n", "<leader>Cr", "<cmd>CellularAutomaton make_it_rain<cr>", { desc = "Code Rain" })
  end,
}
