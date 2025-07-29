return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html", "blade", "antlers", "htmldjango" },
        },
        emmet_language_server = {
          filetypes = { "html", "blade", "antlers" },
        },
        harper_ls = {
          enabled = true,
          filetypes = { "markdown" },
          settings = {
            ["harper-ls"] = {
              userDictPath = "~/.dotfiles/vim/spell/en.utf-8.add",
              linters = {
                ToDoHyphen = false,
                SpellCheck = false,
              },
              isolateEnglish = true,
              markdown = {
                IgnoreLinkTitle = true,
              },
            },
          },
        },
        tailwindcss = {
          filetypes = { "html", "htmldjango", "blade", "antlers", "css" },
        },
        antlersls = {
          filetypes = { "html", "antlers" },
        },
        jsonls = {
          filetypes = { "json" },
        },
        yamlls = {
          filetypes = { "yaml" },
        },
        lua_ls = {
          filetypes = { "lua" },
        },
        vimls = {
          filetypes = { "vim" },
        },
      },

      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "pint", "php_cs_fixer" },
      },
    },
  },

  -- Remove phpcs linter.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = {},
      },
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
