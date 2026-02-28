return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },
  {
    "nvim-mini/mini.animate",
    opts = {
      cursor = { enable = false },
      open = {
        enable = false,
      },
      close = {
        enable = false,
      },
    },
  },

  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10,
    keys = {
      { "p" },
      { "P" },
      { "n" },
      { "N" },
      { "*" },
      { "u" },
      { "<C-r>" },
    },
    opts = {
      disable_warnings = false,
      transparency_color = "#2a2139",
      overwrite = {
        default_animation = "fade",
        search = { enabled = true },
        paste = {
          enabled = true,
          default_animation = "fade",
          paste_mapping = "p", -- Paste after cursor
          Paste_mapping = "P", -- Paste before cursor
        },
        undo = { enabled = true },
        redo = { enabled = true },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimAutocmdsDefaults",
        callback = function()
          vim.api.nvim_del_augroup_by_name("lazyvim_highlight_yank")
        end,
      })
    end,
  },
}
