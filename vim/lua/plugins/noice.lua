return {
  "folke/noice.nvim",
  enabled = function()
    return vim.g.started_by_firenvim ~= true
  end,
  -- keys = {
  --   {
  --     "<S-Enter>",
  --     function()
  --       require("noice").redirect(vim.fn.getcmdline())
  --       require("beepboop").play_audio("patdown")
  --     end,
  --     mode = "c",
  --     desc = "Redirect Cmdline",
  --   },
  -- },
}
