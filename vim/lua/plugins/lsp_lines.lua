return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
    require("lsp_lines").setup()
    -- vim.keymap.set("", "<Leader>cL", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = {
        -- highlight_whole_line = false,
        only_current_line = true,
      },
    })
  end,
}
