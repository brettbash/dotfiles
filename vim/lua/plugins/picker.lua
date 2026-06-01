return {
  {
    "alexpasmantier/tv.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function()
      local h = require("tv").handlers

      require("tv").setup({
        layout = "landscape",
        window = {
          width = 0.8,
          height = 0.8,
          border = "none",
          title = " tv ",
          title_pos = "center",
        },
        channels = {
          text = {
            keybinding = "<leader>sg",
            handlers = {
              ["<CR>"] = h.open_at_line,
              ["<C-q>"] = h.send_to_quickfix,
              ["<C-s>"] = h.open_in_split,
              ["<C-v>"] = h.open_in_vsplit,
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },
          files = {
            handlers = {
              ["<CR>"] = h.open_as_files,
              ["<C-q>"] = h.send_to_quickfix,
              ["<C-s>"] = h.open_in_split,
              ["<C-v>"] = h.open_in_vsplit,
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },
          ["git-log"] = {
            keybinding = "<leader>gl",
            handlers = {
              ["<CR>"] = function(entries)
                if #entries > 0 then
                  vim.cmd("enew | setlocal buftype=nofile bufhidden=wipe")
                  vim.cmd("silent 0read !git show " .. vim.fn.shellescape(entries[1]))
                  vim.cmd("1delete _ | setlocal filetype=git nomodifiable")
                  vim.cmd("normal! gg")
                end
              end,
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },
        },
        global_keybindings = {
          channels = "<leader>tv",
        },
        quickfix = {
          auto_open = true,
        },
      })
    end,
  },
}
