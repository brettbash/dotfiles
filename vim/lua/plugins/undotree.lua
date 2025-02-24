return {
  "debugloop/telescope-undo.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  keys = {
    {
      "<leader>U",
      "<cmd>Telescope undo<cr>",
      desc = "Undotree  ",
    },
  },
  opts = {
    extensions = {
      undo = {
        side_by_side = true,
        layout_config = {
          preview_width = 0.75,
        },
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("undo")
  end,
}
