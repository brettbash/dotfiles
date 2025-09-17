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
    event = "TextYankPost",
    keys = {
      { "p" },
      { "P" },
      { "n" },
      { "N" },
      { "*" },
      { "u" },
      { "<C-r>" },
      -- {
      --   "n",
      --   function()
      --     require("tiny-glimmer").search_next()
      --     vim.api.nvim_feedkeys("zzzv", "n", false)
      --   end,
      --   { noremap = true, silent = true },
      -- },
      -- {
      --   "N",
      --   function()
      --     require("tiny-glimmer").search_prev()
      --     vim.api.nvim_feedkeys("zzzv", "n", false)
      --   end,
      --   { noremap = true, silent = true },
      -- },
    },
    opts = {
      disable_warnings = false,
      transparency_color = "#2a2139",
      overwrite = {
        -- default_animation = "rainbow",
        search = { enabled = true },
        paste = {
          enabled = true,
          paste_mapping = {
            lhs = "p",
            rhs = "<Plug>(YankyPutAfter)",
          },
          Paste_mapping = {
            lhs = "P",
            rhs = "<Plug>(YankyPutBefore)",
          },
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
