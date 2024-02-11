return {
  "whleucka/reverb.nvim",
  event = "BufReadPre",
  opts = {
    -- ! Doesn't seem to work on MacOS
    sounds = {
      -- add custom sound paths for other events here
      -- eg. EVENT = "/some/path/to/sound.mp3"

      -- BufRead = "/Users/brettbash/.config/nvim/sounds/start.ogg",
      -- BufRead = "/sounds/start.ogg",
      -- BufRead = { path = "~/.config/nvim/sounds/start.ogg", volume = 50 },

      -- BufWrite = { path = "~/.config/nvim/sounds/start.ogg", volume = 50 },
      -- BufWrite = { path = sound_dir .. "save.ogg", volume = 0 - 100 },
    },
  },
}
