return {
  "folke/noice.nvim",
  enabled = function()
    return vim.g.started_by_firenvim ~= true
  end,
}
