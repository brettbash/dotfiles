return {
  "zbirenbaum/copilot.lua",
  requires = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
  },
  opts = {
    -- These are disabled in the default configuration.
    suggestion = { enabled = true },
    panel = { enabled = true },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
