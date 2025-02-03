return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    preview = {
      icon_provider = "mini",
    },

    config = function()
      require("markview").setup({
        markdown = {
          headings = {
            enable = true,
            shift_width = 0,

            heading_1 = {
              style = "label",
              sign = " ",
              sign_hl = "MarkviewHeading1Sign",

              padding_left = " ",
              padding_right = " ╱  ╱  ╱ ",
              corner_right = "",
              corner_right_hl = "MarkviewPalette1Fg",
              hl = "MarkviewHeading1",
            },
            heading_2 = {
              style = "label",
              sign = " ",
              sign_hl = "MarkviewHeading2Sign",

              padding_left = " ",
              padding_right = "  ╱  ╱ ",
              corner_right = "",
              corner_right_hl = "MarkviewPalette2Fg",
              hl = "MarkviewHeading2",
            },
            heading_3 = {
              style = "label",

              padding_left = " ",
              padding_right = " ╱  ╱ ",
              corner_right = "",
              corner_right_hl = "MarkviewPalette3Fg",
              hl = "MarkviewHeading3",
            },
            heading_4 = {
              style = "label",

              padding_left = " ",
              padding_right = "  ╱ ",
              corner_right = "",
              corner_right_hl = "MarkviewPalette4Fg",
              hl = "MarkviewHeading4",
            },
            heading_5 = {
              style = "label",

              padding_left = " ",
              padding_right = " ╱ ",
              corner_right = "",
              corner_right_hl = "MarkviewPalette5Fg",
              hl = "MarkviewHeading5",
            },
            heading_6 = {
              style = "label",

              padding_left = " ",
              padding_right = " ",
              corner_right = "",
              corner_right_hl = "MarkviewPalette6Fg",
              hl = "MarkviewHeading6",
            },
          },

          horizontal_rules = {
            enable = true,

            parts = {
              {
                type = "repeating",
                repeat_amount = function()
                  local textoff = math.max(vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff, 7)

                  return math.floor((vim.o.columns - textoff - 3) / 4)
                end,

                text = "  ",

                hl = "MarkviewDivider",
              },
            },
          },

          -- metadata_minus = {
          --   enable = true,
          --
          --   hl = "MarkviewFrontMatter",
          --   border_hl = "MarkviewFrontMatterFg",
          --
          --   border_top = "-",
          --   border_bottom = "-",
          -- },

          -- metadata_plus = {
          --   enable = true,
          --
          --   hl = "MarkviewFrontMatter",
          --   border_hl = "MarkviewFrontMatterFg",
          --
          --   border_top = "-",
          --   border_bottom = "-",
          -- },

          list_items = {
            indent_size = 2,
            shift_width = 2,

            marker_minus = {
              add_padding = true,
            },

            marker_plus = {
              add_padding = false,
            },

            marker_star = {
              add_padding = false,
            },

            marker_dot = {
              add_padding = false,
            },

            marker_parenthesis = {
              add_padding = false,
            },
          },
        },
      })
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
}
