return {
  "axsaucedo/neovim-power-mode",
  config = function()
    require("power-mode").setup({
      auto_enable = false,
      particles = { preset = "stars" },
      -- Cyberpunk neon color palette
      -- Each: { gui_fg, gui_bg, ctermfg, ctermbg }
      colors = {
        color_1 = { "#00FFFF", default, 14, default }, -- Cyan
        color_2 = { "#FF1493", default, 199, default }, -- Pink
        color_3 = { "#BF00FF", default, 129, default }, -- Purple
        color_4 = { "#39FF14", default, 46, default }, -- Green
        color_5 = { "#FF6600", default, 202, default }, -- Orange
        color_6 = { "#FFD700", default, 220, default }, -- Gold
        color_7 = { "#00FF88", default, 48, default }, -- Teal
        color_8 = { "#FF00FF", default, 201, default }, -- Magenta
      },
      -- fire_wall = { enabled = true },
    })
  end,

  keys = {
    {
      "<leader>pp",
      "<cmd>PowerModeToggle<cr><cmd>lua require('beepboop').play_audio('knuckle')<cr><cmd>lua require('beepboop').play_audio('toasty')<cr>",
      desc = "Power Mode Toggle ⚡",
    },
  },
}
