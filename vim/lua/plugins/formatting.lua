return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gr", false }
    keys[#keys + 1] = { "gR", vim.lsp.buf.references, { desc = "References" } }

    local ret = {
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
    }
  end,
}
