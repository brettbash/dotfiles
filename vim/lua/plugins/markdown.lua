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
            enable = false,
            indent_size = 2,
            shift_width = 2,

            marker_minus = {
              text = "",
              add_padding = true,
              conceal_on_checkboxes = true,
            },

            marker_plus = {
              add_padding = false,
              conceal_on_checkboxes = true,
            },

            marker_star = {
              add_padding = false,
              conceal_on_checkboxes = true,
            },

            marker_dot = {
              add_padding = false,
              conceal_on_checkboxes = true,
            },

            marker_parenthesis = {
              add_padding = false,
              conceal_on_checkboxes = true,
            },
          },
        },

        markdown_inline = {
          checkboxes = {
            enable = false,
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
  {
    "bngarren/checkmate.nvim",
    ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {
      -- checkmate.Config
      todo_states = {
        checked = {
          marker = "󰄳",
        },
        unchecked = {
          marker = "󰄰",
        },
        in_progress = {
          marker = "󱎖",
          markdown = ".", -- Saved as `- [.]`
          type = "incomplete", -- Counts as "not done"
          order = 50,
          style = { fg = "#ff8b39" },
        },
        cancelled = {
          marker = "󰯈",
          markdown = "c", -- Saved as `- [c]`
          type = "complete", -- Counts as "done"
          order = 2,
        },
        on_hold = {
          marker = "󱙝",
          markdown = "/", -- Saved as `- [/]`
          type = "inactive", -- Ignored in counts
          order = 100,
        },
      },

      style = {
        CheckmateTodoCountIndicator = { fg = "#00ffff" },
        CheckmateCheckedMarker = { fg = "#03edf9" },
        CheckmateInProgressMarker = { fg = "#f97e72" },
        CheckmateUncheckedMarker = { fg = "#f3e70f" },
      },

      metadata = {
        -- Example: A @priority tag that has dynamic color based on the priority value
        priority = {
          style = function(context)
            local value = context.value:lower()
            if value == "high" then
              return { fg = "#ff00ff", bold = true }
            elseif value == "medium" then
              return { fg = "#fe4450" }
            elseif value == "low" then
              return { fg = "#55beff" }
            else -- fallback
              return { fg = "#55beff" }
            end
          end,
          get_value = function()
            return "medium" -- Default priority
          end,
          choices = function()
            return { "low", "medium", "high" }
          end,
          key = "<leader>Tp",
          sort_order = 10,
          jump_to_on_insert = "value",
          select_on_insert = true,
        },
        -- Example: A @started tag that uses a default date/time string when added
        started = {
          aliases = { "init" },
          style = { fg = "#55beff" },
          get_value = function()
            return tostring(os.date("%Y-%m-%d %H:%M"))
          end,
          key = "<leader>Ts",
          sort_order = 20,
        },
        -- Example: A @done tag that also sets the todo item state when it is added and removed
        done = {
          aliases = { "completed", "finished" },
          style = { fg = "#7ee787" },
          get_value = function()
            return tostring(os.date("%Y-%m-%d %H:%M"))
          end,
          key = "<leader>Td",
          on_add = function(todo_item)
            require("checkmate").set_todo_item(todo_item, "checked")
          end,
          on_remove = function(todo_item)
            require("checkmate").set_todo_item(todo_item, "unchecked")
          end,
          sort_order = 30,
        },
      },

      files = { "*.md" }, -- any .md file (instead of defaults)
    },
  },
}
