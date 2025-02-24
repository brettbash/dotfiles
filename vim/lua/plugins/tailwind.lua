return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      html = {
        filetypes = { "html", "blade", "antlers", "htmldjango" },
      },
      emmet_language_server = {
        filetypes = { "html", "blade", "antlers" },
      },
      tailwindcss = {
        filetypes = { "html", "htmldjango", "blade", "antlers", "css" },
      },
      antlersls = true,
      jsonls = true,
      yamlls = true,
      vimls = true,
      tailwindcss = {},
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}
