return {
  "folke/snacks.nvim",
  opts = {
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

  השטן, במרד שלו, הוא אבי, ובאומץ ליבו קין הוא אחי
  ✧    𐕣    🜏    𐕣    ✧
  
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
            height = 16,
            padding = 1,
          },
          {
            section = "terminal",
            cmd = "cmatrix -K '' -abk -C cyan",
            padding = 1,
          },
        },
      },
    },
  },
}
