return {
  dir = vim.fn.expand("~/.dotfiles/vim/plugins/power-mode"),
  name = "power-mode",
  config = function()
    require("power-mode").setup({
      auto_enable = false,
      particles = { preset = "stars" },
      -- Cyberpunk neon color palette
      -- Each: { gui_fg, gui_bg, ctermfg, ctermbg }
      colors = {
        color_1 = { "#03edf9", default, 14, default }, -- Cyan
        color_2 = { "#ff7edb", default, 199, default }, -- Pink
        color_3 = { "#5f3fff", default, 129, default }, -- Purple
        color_4 = { "#7ee787", default, 46, default }, -- Green
        color_5 = { "#ff8b39", default, 202, default }, -- Orange
        color_6 = { "#fede5d", default, 220, default }, -- Gold
        color_7 = { "#88d1ff", default, 48, default }, -- Teal
        color_8 = { "#FF00FF", default, 201, default }, -- Magenta
      },
      -- fire_wall = { enabled = true },
      combo = {
        enabled = true, -- Show combo counter
        position = "top-right", -- "top-right"|"top-left"|"bottom-right"|"bottom-left"
        width = 21, -- Window width
        height = 6, -- Window height
        timeout = 3000, -- ms before combo resets
        thresholds = { 10, 25, 50, 100, 150 }, -- Level escalation thresholds
        shake = true, -- Shake combo window on keystroke
        shake_intensity = nil, -- Override: { min, max } (nil = auto)
        exclamations = { -- Random phrases at milestones
          "UNSTOPPABLE!",
          "GODLIKE!",
          "RAMPAGE!",
          "MEGA KILL!",
          "DOMINATING!",
          "WICKED SICK!",
          "LEGENDARY!",
        },
        exclamation_interval = 10, -- Show phrase every N keystrokes
        exclamation_duration = 1500, -- ms to display phrase
        level_colors = { -- Colors per level: { gui_fg, ctermfg, gui_bg, ctermbg }
          [0] = { "#97e736", 46, default, default }, -- Green
          [1] = { "#fede5d", 14, default, default }, -- Cyan
          [2] = { "#ff7edb", 199, default, default }, -- Pink
          [3] = { "#ff00ff", 129, default, default }, -- Purple
          [4] = { "#fe4450", 196, default, default }, -- Red
        },
        level_hooks = {
          [2] = "lua require('beepboop').play('excellent')",
          [3] = "lua require('beepboop').play('toasty')",
          [4] = "lua require('beepboop').play('outstanding')",
        },
      },
    })
  end,

  keys = {
    {
      "<leader>pp",
      "<cmd>PowerModeToggle<cr><cmd>lua require('beepboop').play('knuckle')<cr>",
      desc = "Power Mode Toggle ⚡",
    },
  },
}
