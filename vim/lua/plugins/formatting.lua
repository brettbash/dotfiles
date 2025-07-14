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
        antlersls = true,
        jsonls = true,
        yamlls = true,
        vimls = true,
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
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}
