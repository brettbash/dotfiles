return {
  "EggbertFluffle/beepboop.nvim",
  opts = {
    theme = {
      name = "brett",
      sound_directory = vim.fs.joinpath(vim.fn.stdpath("config"), "sounds"),
      max_sounds = 6,
      sound_maps = {
        { trigger_name = "patdown", sound = "Pat Down.wav" },
        { trigger_name = "patup", sound = "Pat Up.wav" },
        { trigger_name = "klink", sound = "Klink.wav" },
        { trigger_name = "knuckle", sound = "Knuckle.wav" },
        { trigger_name = "hollow", sound = "Hollow.wav" },
        { trigger_name = "hitap", sound = "Hi Tap.wav" },
        { trigger_name = "dot", sound = "Dot.wav" },
        { trigger_name = "toasty", sound = "Toasty.mp3", volume = 25 },
        { trigger_name = "scorpion", sound = "GetOverHere.mp3", volume = 30 },
        { trigger_name = "perfect", sound = "perfect.mp3", volume = 20 },
        { trigger_name = "outstanding", sound = "outstanding.mp3", volume = 20 },
        { trigger_name = "excellent", sound = "excellent.mp3", volume = 20 },
        { trigger_name = "waifu", sound = "anime-girl.mp3", volume = 20 },
        { trigger_name = "beeps", sound = "Beeps.mp3" },
        { trigger_name = "starfox", sound = "where-did-you-learn-to-fly.mp3" },

        { auto_command = "VimEnter", sound = "Harpsichord.mp3" },
        -- { auto_command = "VimEnter", sound = "anime-girl.mp3" },
        { auto_command = "VimLeavePre", sound = "AMFM.wav" },
        { auto_command = "BufNewFile", sound = "Dot.wav" },
        { auto_command = "BufWritePost", sound = "Tink.wav" },
        { auto_command = "TextYankPost", sound = "Bloop.wav" },

        { key_map = { mode = "n", key_chord = ":", blocking = false }, sound = "Schlik.wav" },
        { auto_command = "TermOpen", sound = "Klink.wav" },

        -- TODO: 󰜟 Sound Ideas
        -- grug-far
        -- Trouble/Quickfix
      },
    },
    get_binary_method = "build",
    volume = 60,
  },
}
