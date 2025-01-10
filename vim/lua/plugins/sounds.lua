return {
  "EggbertFluffle/beepboop.nvim",
  opts = {
    audio_player = "ffplay",
    max_sounds = 20,
    sound_map = {
      { trigger_name = "patdown", sound = "Pat Down.wav" },
      { trigger_name = "patup", sound = "Pat Up.wav" },
      { auto_command = "VimEnter", sound = "Harpsichord.mp3" },
      { auto_command = "VimEnter", sound = "Fan Fare.mp3" },
      { auto_command = "BufRead", sound = "Knuckle.wav" },
      { auto_command = "BufNewFile", sound = "Dot.wav" },
      { auto_command = "BufDelete", sound = "Hollow.wav" },
      { auto_command = "BufWritePost", sound = "Bam.wav" },
      -- I want this only when the Noice cmdline popup is open, not on viewing a different buffer as well...
      -- { auto_command = "CmdlineEnter", sound = "Schlik.wav" },
      { auto_command = "TermOpen", sound = "Klink.wav" },
      -- 🧠 Additional Sound Ideas:
      ----- TextYankPost
      ----- grug-far
      ----- Harpoon/Arrow
      ----- Harpoon/Arrow
    },
  },
}
