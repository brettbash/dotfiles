return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-media-files.nvim",
  },
  opts = {
    defaults = {
      file_ignore_patterns = {
        -- "Anything you want to ignore",
      },
    },
  },

  config = function()
    require("telescope").setup({
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          -- filetypes = {"png", "jpg", "mp4", "webm", "pdf"},
          -- find command (defaults to `fd`)
          find_cmd = "rg",
        },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("media_files")
  end,
}
