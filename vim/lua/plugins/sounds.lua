return {
  "EggbertFluffle/beepboop.nvim",
  opts = {
    audio_player = "afplay",
    max_sounds = 12,
    volume = 80,
    sound_map = {
      { trigger_name = "patdown", sound = "Pat Down.wav" },
      { trigger_name = "patup", sound = "Pat Up.wav" },
      { trigger_name = "klink", sound = "Klink.wav" },
      { auto_command = "VimEnter", sound = "Harpsichord.mp3" },
      -- { auto_command = "VimEnter", sound = "Fan Fare.mp3" },
      -- { auto_command = "VimLeave", sound = "AMFM.wav" },
      -- { auto_command = "VimLeave", sound = "open_flip1.oga" },
      -- { auto_command = "BufRead", sound = "Hi Tap.wav" },
      { auto_command = "BufNewFile", sound = "Dot.wav" },
      { auto_command = "BufDelete", sound = "Knuckle.wav" },
      { auto_command = "BufWritePost", sound = "Bam.wav" },
      { auto_command = "TextYankPost", sound = "Bloop.wav" },
      --      { key_map = { mode = "n", key_chord = ":", blocking = false }, sound = "Schlik.wav" },
      -- { key_map = { mode = "n", key_chord = "  ", blocking = false }, sound = "Klink.wav" },
      -- { auto_command = "TermOpen", sound = "Klink.wav" },
      -- 🧠 Additional Sound Ideas:
      ----- grug-far
      ----- Harpoon/Arrow
      ----- Harpoon/Arrow
    },
  },
}
