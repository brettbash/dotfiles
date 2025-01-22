return {
  "folke/snacks.nvim",
  opts = {
    scroll = { enabled = false },
    dashboard = {
      preset = {
        header = [[
👽
 ██▒   █▓ ██▓ ███▄ ▄███▓
▓██░   █▒▓██▒▓██▒▀█▀ ██▒
 ▓██  █▒░▒██▒▓██    ▓██░
  ▒██ █░░░██░▒██    ▒██ 
   ▒▀█░  ░██░▒██▒   ░██▒
   ░ ▐░  ░▓  ░ ▒░   ░  ░
   ░ ░░   ▒ ░░  ░      ░
     ░░   ▒ ░░      ░   
      ░   ░         ░   
     ░                  

    ヴィムへようこそ
   💀
        ]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Git", action = "<leader>gg" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          pane = 2,
          {
            section = "terminal",
            cmd = "gif ~/.config/nvim/animations/rei-ayanami-evangelion.gif -b --dither -d 60,15 -C -c",
            height = 15,
            padding = 1,
          },
          {
            section = "terminal",
            cmd = "cmatrix -ba -C cyan",
            padding = 1,
          },
        },
      },
    },

    lazygit = {
      configure = true,
      theme = {
        [241] = { fg = "Special" },
        activeBorderColor = { fg = "MatchParen", bold = true },
        cherryPickedCommitBgColor = { fg = "Identifier" },
        cherryPickedCommitFgColor = { fg = "Function" },
        defaultFgColor = { fg = "Normal" },
        inactiveBorderColor = { fg = "FloatBorder" },
        optionsTextColor = { fg = "Function" },
        searchingActiveBorderColor = { fg = "MatchParen", bold = true },
        selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
        unstagedChangesColor = { fg = "DiagnosticError" },
      },
    },
  },
}
