return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    heading = {
      width = "block",
      sign = false,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      backgrounds = {},
      position = "overlay",
    },
    bullet = {
      icons = { "●", "○", "◆", "◇" },
      right_pad = 1,
      left_pad = 2,
    },
    checkbox = {
      unchecked = {
        icon = "󰄱 ",
      },
      checked = {
        icon = "󰱒 ",
      },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
      },
    },
    pipe_table = {
      preset = "round",
    },
    indent = {
      enabled = true,
      per_level = 2,
      skip_level = 0,
      skip_heading = false,
    },
    link = {
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
      custom = {
        web = { pattern = "^http", icon = "󰖟 " },
        youtube = { pattern = "youtube%.com", icon = "󰗃 " },
        github = { pattern = "github%.com", icon = "󰊤 " },
        neovim = { pattern = "neovim%.io", icon = " " },
        stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
        discord = { pattern = "discord%.com", icon = "󰙯 " },
        reddit = { pattern = "reddit%.com", icon = "󰑍 " },
      },
    },
  },
}
