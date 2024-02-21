return {
  "glepnir/nerdicons.nvim",
  cmd = "NerdIcons",
  keys = {
    { "<leader>cy", "<cmd>NerdIcons<cr>", desc = "NerdIcons" },
  },
  config = function()
    require("nerdicons").setup({
      prompt = "  ",
      preview_prompt = " ",
      width = 0.4,
      down = "<down>",
      up = "<up>",
      copy = "<tab>",
    })
  end,
}
