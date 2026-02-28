return {
  "nvim-telekasten/telekasten.nvim",
  lazy = false,
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    {
      "<leader>z",
      "<cmd>Telekasten panel<cr>",
      desc = "Notes Panel",
    },
    {
      "<leader>zf",
      "<cmd>Telekasten find_notes<cr>",
      desc = "Find Notes",
    },
    {
      "<leader>zd",
      "<cmd>Telekasten find_daily_notes<cr>",
      desc = "Search Daily Notes",
    },
    {
      "<leader>zt",
      "<cmd>Telekasten goto_today<cr>",
      desc = "Today's Log",
    },
    {
      "<leader>zg",
      "<cmd>Telekasten search_notes<cr>",
      desc = "Search Notes",
    },
    {
      "<leader>zz",
      "<cmd>Telekasten follow_link<cr>",
      desc = "Follow Note Link",
    },
    {
      "<leader>zb",
      "<cmd>Telekasten show_backlinks<cr>",
      desc = "Show Note Backlinks",
    },
    {
      "<leader>zI",
      "<cmd>Telekasten insert_img_link<cr>",
      desc = "Insert Image Link",
    },
    {
      "<leader>zn",
      "<cmd>Telekasten new_note<cr>",
      desc = "New Note",
    },
    {
      "<leader>zc",
      "<cmd>Telekasten show_calendar<cr>",
      desc = "Show Calendar",
    },
    {
      "<leader>zi",
      "<cmd>Telekasten insert_link<cr>",
      desc = "Insert Link",
    },
    {
      "<leader>zT",
      "<cmd>Telekasten show_tags<cr>",
      desc = "Show Tags",
    },
    {
      "<leader>zm",
      "<cmd>Telekasten toggle_todo<cr>",
      desc = "Toggle Todo",
    },
    {
      "<leader>zr",
      "<cmd>Telekasten rename_note<cr>",
      desc = "Rename Note",
    },
  },
  config = function()
    local home = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/バッシュ")
    local os = require("os")
    local year = os.date("%Y")
    local month = os.date("%m")

    -- Call insert link automatically when we start typing a link
    vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")

    require("telekasten").setup({
      home = home,
      picker = "snacks",
      dailies = home .. "/Log/" .. year .. "/" .. month,
      weeklies = home .. "/Log/" .. year .. "/weekly",
      template_new_note = home .. "/templates/note.md",
      template_new_daily = home .. "/templates/daily.md",
      template_new_weekly = home .. "/templates/weekly.md",
      image_subdir = "aseets",
      image_link_style = "markdown",

      plug_into_calendar = true,
      calendar_opts = {
        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
        weeknm = 4,
        -- use monday as first day of week: 1 .. true, 0 .. false
        calendar_monday = 1,
        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        calendar_mark = "left-fit",
      },
      subdirs_in_links = true,
      rename_update_links = true,
      media_previewer = "telescope-media-files",
      journal_auto_open = true,
    })
  end,
}
