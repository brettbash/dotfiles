return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-mini/mini.bufremove",
  },
  opts = {
    options = {
      indicator = {
        icon = "",
        style = "none",
      },
      separator_style = { "", "" },
      show_close_icon = false,
      show_buffer_close_icons = false,
      modified_icon = "󰯆 ",
      -- stylua: ignore
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      -- stylua: ignore
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local icons = require("lazyvim.config").icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,

      offsets = {
        {
          text = "ファイルツリー",
          filetype = "neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },

    highlights = {
      fill = {
        bg = "none",
      },
      background = {
        bg = "none",
      },
      tab = {
        bg = "none",
      },
      duplicate = {
        bg = "none",
      },

      buffer_selected = {
        fg = "#00ffff",
        bg = "none",
      },
      buffer_visible = {
        fg = "#ff00ff",
        bg = "none",
      },

      modified_selected = {
        fg = "#00ffff",
        bg = "none",
      },

      offset_separator = {
        fg = "#00ffff",
        bg = "none",
      },

      pick_selected = {
        fg = "#00ffff",
      },

      indicator_selected = {
        fg = "#00ffff",
      },

      pick = {
        bg = "none",
      },

      hint_visible = {
        fg = "#ff00ff",
      },
      hint_selected = {
        fg = "#00ffff",
        sp = "#00ffff",
      },

      warning = {
        bg = "none",
      },
      warning_selected = {
        fg = "#00ffff",
      },
      warning_visible = {
        fg = "#ff00ff",
      },
      warning_diagnostic = {
        bg = "none",
      },

      warning_diagnostic_selected = {
        fg = "#fede5d",
        sp = "#fede5d",
      },
      diagnostic_selected = {
        fg = "#fede5d",
      },
      hint_diagnostic_selected = {
        fg = "#fede5d",
      },
      info_diagnostic_selected = {
        fg = "#fede5d",
      },
      error_visible = {
        fg = "#ff00ff",
      },
      error_selected = {
        fg = "#00ffff",
      },
      tab_close = {
        bg = "none",
      },
      close_button = {
        bg = "none",
      },
      close_button_visible = {
        bg = "none",
      },
      close_button_selected = {
        bg = "none",
        fg = "#00ffff",
      },
      numbers_selected = {
        bg = "none",
        fg = "#00ffff",
      },
      separator = {
        fg = "#463465",
        bg = "none",
      },
      tab_separator = {
        fg = "#463465",
        bg = "none",
      },
      tab_separator_selected = {
        bg = "none",
        fg = "#00ffff",
      },
      separator_selected = {
        bg = "none",
        fg = "#00ffff",
      },
      separator_visible = {
        bg = "none",
        fg = "#00ffff",
      },
    },
  },

  config = function(_, opts)
    require("bufferline").setup(opts)

    vim.keymap.set({ "n", "v" }, "<leader>bn", "<cmd>BufferLineMoveNext<cr>", { desc = "Buffer Move Next" })
    vim.keymap.set({ "n", "v" }, "<leader>bp", "<cmd>BufferLineMovePrev<cr>", { desc = "Buffer Move Prev" })

    vim.keymap.set(
      { "n", "v" },
      "<leader>bo",
      "<cmd>lua require('beepboop').play_audio('knuckle')<cr><cmd>BufferLinePick<cr>",
      { desc = "Pick Buffer" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>bc",
      "<cmd>lua require('beepboop').play_audio('dot')<cr><cmd>BufferLinePickClose<cr>",
      { desc = "Pick Buffer to Close" }
    )

    vim.keymap.set({ "n", "v" }, "<leader>bt", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin a Buffer" })

    vim.keymap.set("n", "<leader>bO", function()
      Snacks.bufdelete.other()
    end, { desc = "Delete Other Buffers" })

    vim.keymap.set(
      { "n", "v" },
      "<leader>bsd",
      "<cmd>BufferLineSortByDirectory<cr>",
      { desc = "Sort Buffers by Directory" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>bse",
      "<cmd>BufferLineSortByExtension<cr>",
      { desc = "Sort Buffers by Extension" }
    )
    vim.keymap.set({ "n", "v" }, "<leader>bst", "<cmd>BufferLineSortByTabs<cr>", { desc = "Sort Buffers by Tabs" })

    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
