return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  event = "VeryLazy",
  opts = function(_, opts)
    require("grapple").setup({
      statusline = {
        icon = "󰛢 ───  ",
        active = "[󰯈 %s]",
        inactive = " %s ",
      },
    })
    table.insert(opts.sections.lualine_x, 1, { "grapple", color = { fg = "#e5fe5d" } })
  end,
}
