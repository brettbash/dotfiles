return {
  "dzfrias/arena.nvim",
  event = "BufWinEnter",
  -- Calls `.setup()` automatically
  window = {
    width = 60,
    height = 10,

    -- Options to apply to the arena window.
    opts = {},
  },
  keys = {
    {
      "<leader>ba",
      "<cmd>lua require('arena').open()<cr>",
      desc = "Arena",
    },
  },

  config = true,
}
