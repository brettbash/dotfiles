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

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      { "tzachar/cmp-ai" },
    },

    opts = function(_, opts)
      require("cmp").setup({
        sources = {
          { name = "cmp_ai" },
        },
      })
      -- table.insert(opts.sources, 1, "cmp_ai")
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
}
