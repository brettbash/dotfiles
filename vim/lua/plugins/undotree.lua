return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>U",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undotree  ",
      },
    },
  },
}
