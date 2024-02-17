return {
  "https://git.sr.ht/~swaits/scratch.nvim",
  lazy = true,
  keys = {
    { "<leader>Bs", "<cmd>Scratch<cr>", desc = "Scratch Buffer", mode = "n" },
    { "<leader>BS", "<cmd>ScratchSplit<cr>", desc = "Scratch Buffer (split)", mode = "n" },
  },
  cmd = {
    "Scratch",
    "ScratchSplit",
  },
  opts = {},
}
