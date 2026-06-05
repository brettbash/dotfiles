return {
  "EggbertFluffle/beepboop.nvim",
  opts = {
    theme = {
      name = "cyberblade",
      sound_directory = vim.fs.joinpath(vim.fn.expand("~/.dotfiles"), "vim", "sounds"),
      max_sounds = 15,
      sound_maps = {
        { trigger = "beeps", sound = "Beeps.mp3" },
        { trigger = "dot", sound = "Dot.wav" },
        { trigger = "excellent", sound = "excellent.mp3", volume = 20 },
        { trigger = "flipOpen", sound = "open_flip3.wav" },
        { trigger = "hitap", sound = "HiTap.wav" },
        { trigger = "hollow", sound = "Hollow.wav" },
        { trigger = "klink", sound = "Klink.wav" },
        { trigger = "knuckle", sound = "Knuckle.wav" },
        { trigger = "outstanding", sound = "outstanding.mp3", volume = 20 },
        { trigger = "patdown", sound = "PatDown.wav" },
        { trigger = "patup", sound = "PatUp.wav" },
        { trigger = "perfect", sound = "perfect.mp3", volume = 20 },
        { trigger = "pop", sound = "pop.wav", volume = 5 },
        { trigger = "scorpion", sound = "GetOverHere.mp3", volume = 30 },
        { trigger = "starfox", sound = "where-did-you-learn-to-fly.mp3" },
        { trigger = "toasty", sound = "Toasty.mp3", volume = 25 },
        { trigger = "waifu", sound = "anime-girl.mp3", volume = 20 },

        { autocommand = "VimEnter", sound = "Harpsichord.mp3" },
        { autocommand = "VimEnter", sound = "FanFare.mp3", volume = 12 },
        { autocommand = "BufNewFile", sound = "Dot.wav" },
        { autocommand = "BufWritePost", sound = "Tink.wav" },
        { autocommand = "TextYankPost", sound = "Bloop.wav" },

        { keymap = { mode = "n", keychord = ":", blocking = false }, sound = "Schlik.wav" },
        { autocommand = "TermOpen", sound = "Klink.wav" },
      },
    },
    get_binary_method = "build",
    volume = 60,
  },
  config = function(_, opts)
    require("beepboop").setup(opts)

    -- VimLeavePre: direct afplay (binary already quitting)
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        local sound_path = vim.fs.joinpath(opts.theme.sound_directory, "AMFM.wav")
        local volume = (opts.volume or 60) / 100
        vim.system({ "afplay", "-v", tostring(volume), sound_path })
      end,
    })
  end,
}
