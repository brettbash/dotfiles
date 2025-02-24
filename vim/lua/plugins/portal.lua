return {
  "cbochs/portal.nvim",
  dependencies = {
    "cbochs/grapple.nvim",
  },
  config = function() end,

  keys = {
    {
      "<leader>P",
      "<cmd>lua require('beepboop').play_audio('patdown')<cr><cmd>lua require('portal.builtin').grapple.tunnel()<cr>",
      desc = "Harpoon Portal",
    },
    {
      "<leader>J",
      "<cmd>lua require('beepboop').play_audio('patdown')<cr><cmd>lua require('portal.builtin').jumplist.tunnel()<cr>",
      desc = "Jumplist Portal",
    },
    {
      "<leader>T",
      "<cmd>lua require('beepboop').play_audio('patdown')<cr><cmd>lua require('portal.builtin').changelist.tunnel()<cr>",
      desc = "Changelist Portal",
    },
    {
      "<leader>F",
      "<cmd>lua require('beepboop').play_audio('patdown')<cr><cmd>lua require('portal.builtin').quickfix.tunnel()<cr>",
      desc = "Quickfix Portal",
    },
  },
}
