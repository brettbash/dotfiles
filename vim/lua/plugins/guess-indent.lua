return {
  "NMAC427/guess-indent.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    auto_cmd = true,
    override_editorconfig = false,
    filetype_exclude = { "netrw", "tutor" },
    buftype_exclude = { "help", "nofile", "terminal", "prompt" },
    on_tab_options = { ["expandtab"] = false },
    on_space_options = { ["expandtab"] = true, ["tabstop"] = "detected", ["softtabstop"] = "detected", ["shiftwidth"] = "detected" },
  },
  config = function(_, opts)
    require("guess-indent").setup(opts)
    vim.cmd("silent! GuessIndent")
  end,
}
