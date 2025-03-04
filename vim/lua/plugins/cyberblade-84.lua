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
    local fg_dark = "#6971a2"

    local fg = "#a8c7fa"

    local pink = "#ff7edb"
    local magenta = "#ff00ff"
    local magenta2 = "#ff007c"
    local hot = "#F70067"

    local cyan = "#03edf9"
    local cyan1 = "#00ffff"

    local blue = "#55beff"
    local blue1 = "#abf3fd"
    local blue2 = "#5f3fff"
    local blue3 = "#640FDA"
    local blue4 = "#370ABE"
    local blue5 = "#00aaf9"

    local green = "#72f1b8"
    local green1 = "#7ee787"
    local teal = "#97E736"

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
        hl.LspInlayHint = { fg = fg_darker, bg = black }
        hl.YankyPut = { fg = bg_darker, bg = purple }
        hl.YankyYanked = { fg = bg_darker, bg = yellow2 }
        hl.BufferlineActiveSeparator = {
          bg = c.bg,
          fg = c.bg_dark,
        }
        hl.BufferlineInactiveSeparator = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.NormalFloat = {
          bg = black,
          fg = fg,
        }
        hl.FloatBorder = { fg = cyan1, bg = black }
        hl.FloatTitle = { fg = magenta, bg = black }

        -- Search & Flash
        hl.MatchParen = { fg = magenta, bg = black }
        hl.IncSearch = { fg = magenta, bg = cyan }
        hl.Search = { fg = yellow, bg = magenta }
        hl.FlashLabel = { fg = yellow3, bg = hot }
        hl.FlashMatch = { fg = blue4, bg = blue5 }

        -- Portal
        hl.PortalLabel = { fg = yellow3, bg = hot }

        -- Spelling
        hl.SpellBad = {
          undercurl = true,
          sp = red,
        }

        -- Copilot
        hl.CopilotSuggestion = {
          fg = c.comment,
        }

        hl.LineNrAbove = { fg = fg_dark }
        hl.CursorLineNr = { fg = magenta }
        hl.LineNr = { fg = magenta }
        hl.LineNrBelow = { fg = fg_dark }
        hl.Folded = { bg = bg_dark }
        hl.FoldColumn = {
          bg = black,
          fg = cyan,
        }
        hl.SignColumn = { bg = black }

        -- WhichKey
        hl.WhichKey = {
          fg = cyan1,
          bg = black,
        }
        hl.WhichKeyTitle = {
          fg = magenta,
          bg = black,
        }
        hl.WhichKeyNormal = {
          fg = cyan1,
          bg = black,
        }
        hl.WhichKeyBorder = {
          fg = cyan1,
          bg = black,
        }

        -- Oil (MiniFiles)
        hl.MiniFilesBorder = {
          bg = black,
          fg = cyan1,
        }
        hl.MiniFilesTitle = {
          bg = black,
          fg = magenta,
        }
        hl.MiniFilesTitleFocused = {
          bg = black,
          fg = cyan1,
        }

        -- FZF
        hl.FzfLuaFzfGutter = { bg = black }
        hl.FzfLuaNormal = { bg = black }
        hl.FzfLuaBackdrop = { bg = black }
        hl.FzfLuaTitle = { fg = cyan1, bg = black }
        hl.FzfLuaPreviewBorder = { fg = cyan1, bg = black }
        hl.FzfLuaBorder = { fg = cyan1, bg = black }
        hl.FzfLuaPreviewTitle = { fg = magenta, bg = black }
        hl.FzfLuaCursorLine = { fg = magenta }
        hl.FzfLuaFzfPointer = { fg = yellow }
        hl.FzfLuaFzfCursorLine = { fg = c.bg_darker, bg = blue3 }
        hl.FzfLuaFzfMatch = { bg = yellow1 }
        hl.FzfLuaDirPart = { fg = purple }
        hl.FzfLuaFilePart = { fg = green }
        hl.FzfLuaSearch = { fg = yellow, bg = blue2 }

        -- Telescope
        hl.TelescopeNormal = {
          bg = black,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = black,
          fg = cyan1,
        }
        hl.TelescopePromptNormal = {
          bg = black,
        }
        hl.TelescopePromptBorder = {
          bg = black,
          fg = magenta,
        }
        hl.TelescopePromptTitle = {
          bg = black,
          fg = c.cyan1,
        }
        hl.TelescopeResultsTitle = {
          bg = black,
          fg = magenta,
        }
        hl.TelescopeSelection = {
          bg = yellow2,
          fg = blue2,
        }

        -- Markdown
        hl["@markup.heading.1.markdown"] = { fg = magenta, italic = true }
        hl["@markup.heading.2.markdown"] = { fg = yellow, italic = true }
        hl["@markup.heading.3.markdown"] = { fg = teal, italic = true }
        hl.MarkviewTableBorder = { fg = cyan }
        hl.MarkviewTableHeader = { fg = magenta }
        hl.MarkviewDivider = { fg = blue3 }

        hl.MarkviewCheckboxProgress = { fg = yellow1 }
        hl.MarkviewCheckboxPending = { fg = orange }
        hl.MarkviewCheckboxChecked = { fg = cyan }
        hl.MarkviewFrontMatter = { bg = black }
        hl.MarkviewFrontMatterFg = { fg = cyan }
        hl.MarkviewCodeInfo = { bg = black }
        hl.MarkviewInlineCode = { bg = black }
        hl.MarkviewCode = { bg = black }

        hl.MarkdownIcon0 = { fg = magenta }
        hl.MarkdownIcon1 = { fg = yellow1 }
        hl.MarkdownIcon2 = { fg = teal }
        hl.MarkdownIcon3 = { fg = orange }
        hl.MarkdownIcon4 = { fg = cyan }
        hl.MarkdownIcon5 = { fg = pink }
        hl.MarkdownIcon6 = { fg = purple }

        hl.CalNavi = { fg = cyan, bg = black }
        hl.CalRuler = { fg = green, bg = black }
        hl.CalHeader = { fg = magenta, bg = black }
      end,

      on_colors = function(colors)
        colors.dark2 = fg_dark
        colors.dark3 = fg_darker
        colors.bg_sidebar = bg_darker
        colors.bg = bg
        colors.fg = fg
        colors.bg_dark = bg_dark
        colors.bg_statusline = bg_dark
        colors.bg_highlight = black
        colors.fg_gutter = bg_light
        colors.bg_visual = blue3

        colors.cyan = cyan
        colors.blue0 = purple
        colors.blue = green
        colors.blue1 = cyan1
        colors.blue2 = yellow2
        colors.blue3 = green1
        colors.blue4 = blue1
        colors.blue6 = hot
        colors.blue4 = magenta2
        colors.blue5 = blue

        colors.magenta = pink
        colors.magenta2 = magenta
        colors.purple = purple

        colors.green = orange
        colors.green1 = yellow
        colors.green2 = green1

        colors.yellow = red
        colors.teal = teal
        colors.orange = yellow3

        colors.red = yellow2
        colors.red1 = red1
        colors.comment = fg_dark
      end,
    })
  end,
}
