return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        tools = {
          crush = {},
        },
      },
    },
    keys = {
      {
        "<leader>aA",
        function()
          require("sidekick.cli").toggle({ name = "crush" })
        end,
        desc = "Sidekick (Crush)",
      },
    },
  },
}
