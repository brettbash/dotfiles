return {
  "petertriho/nvim-scrollbar",
  config = function()
    local colors = require("tokyonight.colors").setup()
    require("scrollbar").setup({
      show_in_active_only = true,
      hide_if_all_visible = true,
      handle = {
        color = "#463465",
      },
      marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
      },
    })
  end,
}
