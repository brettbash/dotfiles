return {
  "gbprod/phpactor.nvim",
  ft = "php",
  opts = {
    install = {
      path = vim.fn.stdpath("data") .. "/mason/phpactor",
      bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
    },
  },

  keys = {
    {
      "<leader>pm",
      function()
        require("phpactor").rpc("context_menu", {})
      end,
      desc = "Open Context Menu",
    },

    {
      "<leader>pi",
      function()
        require("phpactor").rpc("import_class", {})
      end,
      desc = "Import Class",
    },
  },
}
