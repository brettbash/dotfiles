return {
  {
    "OXY2DEV/markview.nvim",
    branch = "dev",
    lazy = false,
    preview = {
      icon_provider = "mini",
    },

    config = function()
      require("markview").setup({

        experimental = {
          check_rtp = false,
          check_rtp_message = false,
        },
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

          metadata_minus = {
            enable = true,

            hl = "MarkviewFrontMatter",
            border_hl = "MarkviewFrontMatterFg",

            border_top = "─",
            border_bottom = "─",
          },

          metadata_minus_static = {
            enable = true,

            hl = "MarkviewFrontMatter",
            border_hl = "MarkviewFrontMatterFg",

            border_top = "─",
            border_bottom = "─",
          },

          metadata_plus = {
            enable = true,

            hl = "MarkviewFrontMatter",
            border_hl = "MarkviewFrontMatterFg",

            border_top = "─",
            border_bottom = "─",
          },

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

        yaml = {
          properties = {
            enable = true,

            data_types = {
              ["text"] = {
                text = " 󰗊  ",
                hl = "MarkdownIcon4",
              },
              ["list"] = {
                text = " 󰝖  ",
                hl = "MarkdownIcon5",
              },
              ["number"] = {
                text = "   ",
                hl = "MarkdownIcon6",
              },
              ["checkbox"] = {
                ---@diagnostic disable
                text = function(_, item)
                  return item.value == "true" and " 󰄲  " or " 󰄱  "
                end,
                ---@diagnostic enable
                hl = "MarkdownIcon6",
              },
              ["date"] = {
                text = " 󰃭  ",
                hl = "MarkdownIcon2",
              },
              ["date_&_time"] = {
                text = " 󰥔  ",
                hl = "MarkdownIcon3",
              },
            },

            default = {
              use_types = true,

              border_top = " │ ",
              border_middle = " │ ",
              border_bottom = " ╰╸",

              border_hl = "MarkviewComment",
            },

            ["^title$"] = {
              match_string = "^title$",
              use_types = false,
              text = "   ",
              hl = "MarkdownIcon4",
            },

            ["^type$"] = {
              match_string = "^type$",
              use_types = false,
              text = "   ",
              hl = "MarkdownIcon2",
            },

            ["^tags$"] = {
              match_string = "^tags$",
              use_types = false,
              text = " 󰓹  ",
              hl = "MarkdownIcon0",
            },

            ["^aliases$"] = {
              match_string = "^aliases$",
              use_types = false,
              text = " 󱞫  ",
              hl = "MarkdownIcon4",
            },

            ["^cssclasses$"] = {
              match_string = "^cssclasses$",
              use_types = false,
              text = "   ",
              hl = "MarkdownIcon4",
            },

            ["^publish$"] = {
              match_string = "^publish$",
              use_types = false,
              text = "   ",
              hl = "MarkdownIcon4",
            },

            ["^permalink$"] = {
              match_string = "^permalink$",
              use_types = false,
              text = "   ",
              hl = "MarkdownIcon4",
            },

            ["^description$"] = {
              match_string = "^description$",
              use_types = false,
              text = " 󰋼  ",
              hl = "MarkdownIcon5",
            },

            ["^brief$"] = {
              match_string = "^brief$",
              use_types = false,
              text = " 󰙴  ",
              hl = "MarkdownIcon5",
            },

            ["^image$"] = {
              match_string = "^image$",
              use_types = false,
              text = " 󰋫  ",
              hl = "MarkdownIcon3",
            },

            ["^cover$"] = {
              match_string = "^cover$",
              use_types = false,
              text = " 󰹉  ",
              hl = "MarkdownIcon4",
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
