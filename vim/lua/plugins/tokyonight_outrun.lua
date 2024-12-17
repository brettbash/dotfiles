return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },

  config = function()
    local bg_darker = "#191726"
    local bg_dark = "#251c2e"
    local bg = "#2a2139"
    local bg_light = "#342a50"
    local bg_lighter = "#463465"
    -- "#614D85"
    -- "#b893ce"

    local fg_darker = "#545c7e"
    -- local fg_dark = "#848bbd"
    local fg_dark = "#6971a2"

    local fg = "#a8c7fa"
    -- local fg = "#d9bbdb"
    -- local fg = "#e7cad8"

    local pink = "#ff7edb"
    local magenta = "#ff00ff"
    local magenta2 = "#ff007c"

    local cyan = "#03edf9"
    local cyan1 = "#00ffff"

    local blue = "#55beff"
    local blue1 = "#abf3fd"
    local blue2 = "#5f3fff"
    local blue3 = "#5f3fff"
    local blue4 = "#5f3fff"
    local blue5 = "#5f3fff"
    local blue6 = "#5f3fff"
    local blue7 = "#5f3fff"

    local green = "#72f1b8"
    local green1 = "#7ee787"

    local yellow = "#fede5d"
    local yellow1 = "#f3e70f"
    local yellow2 = "#e5fe5d"
    local yellow3 = "#ffefae"

    local orange = "#ff8b39"
    local red = "#f97e72"
    local red1 = "#fe4450"

    local purple = "#af87ff"
    local purple1 = "#e5b9e7"

    require("tokyonight").setup({
      transparent = true, -- Enable this to disable setting the background color
      on_highlights = function(hl, c)
        hl.BufferlineActiveSeparator = {
          bg = c.bg,
          fg = c.bg_dark,
        }
        hl.BufferlineInactiveSeparator = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.NormalFloat = {
          bg = bg,
          fg = fg,
        }
        hl.FloatBorder = { fg = cyan1, bg = bg_dark }
        hl.FloatTitle = { fg = magenta, bg = c.bg_dark }
        hl.TelescopeNormal = {
          bg = bg,
          fg = c.fg_dark,
        }

        -- Spelling
        hl.SpellBad = {
          undercurl = true,
          sp = red,
        }

        -- Copilot
        hl.CopilotSuggestion = {
          fg = c.comment,
        }

        hl.TelescopeBorder = {
          bg = bg,
          fg = cyan1,
        }

        hl.LineNrAbove = { fg = fg_dark }
        hl.CursorLineNr = { fg = magenta }
        hl.LineNr = { fg = magenta }
        hl.LineNrBelow = { fg = fg_dark }
        hl.Folded = { bg = bg_dark }
        hl.FoldColumn = {
          bg = bg,
          fg = cyan,
        }
        hl.SignColumn = { bg = bg }

        hl.NeoTreeDimText = { fg = fg_dark }

        -- WhichKey
        hl.WhichKey = {
          fg = cyan1,
          bg = bg,
        }
        hl.WhichKeyTitle = {
          fg = magenta,
          bg = bg,
        }
        hl.WhichKeyNormal = {
          fg = cyan1,
          bg = bg,
        }
        hl.WhichKeyBorder = {
          fg = cyan1,
          bg = bg,
        }

        -- Oil (MiniFiles)
        hl.MiniFilesBorder = {
          bg = bg,
          fg = cyan1,
        }
        hl.MiniFilesTitle = {
          bg = bg,
          fg = magenta,
        }
        hl.MiniFilesTitleFocused = {
          bg = bg,
          fg = cyan1,
        }

        -- FZF
        hl.FzfLuaNormal = { bg = bg }
        hl.FzfLuaBackdrop = { bg = bg }
        hl.FzfLuaTitle = { fg = cyan1, bg = bg }
        hl.FzfLuaPreviewBorder = { fg = cyan1, bg = bg }
        hl.FzfLuaBorder = { fg = cyan1, bg = bg }
        hl.FzfLuaPreviewTitle = { fg = magenta, bg = bg }
      end,

      on_colors = function(colors)
        colors.dark2 = fg_dark
        colors.dark3 = fg_darker
        colors.bg_sidebar = bg_darker
        colors.bg = bg
        colors.fg = fg
        colors.bg_dark = bg_dark
        colors.bg_statusline = bg_dark
        colors.bg_highlight = bg_light
        colors.fg_gutter = bg_lighter

        colors.cyan = cyan
        colors.blue0 = purple
        colors.blue = green
        colors.blue1 = cyan1
        colors.blue2 = yellow2
        colors.blue3 = green1
        colors.blue4 = blue1
        colors.blue5 = cyan1
        colors.blue6 = cyan1
        colors.blue6 = cyan

        colors.magenta = pink
        colors.magenta2 = magenta
        colors.purple = purple

        colors.green = orange
        colors.green1 = yellow
        colors.green2 = green1

        colors.yellow = red
        colors.teal = blue
        colors.orange = yellow3

        colors.red = yellow2
        colors.red1 = red1
        colors.comment = fg_dark
      end,
    })
  end,
}
