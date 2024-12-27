return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      emmet_ls = {
        filetypes = {
          "html",
          "css",
          "sass",
          "scss",
          "less",
          "javascript",
          "markdown",
          "typescript",
          "twig",
        },
      },
      eslint = {},
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
}
