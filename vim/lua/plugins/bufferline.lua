return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      indicator = {
        icon = " ",
      },
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

      -- indicator = {
      --   style = "underline",
      -- },
      --

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
        bg = "#191726",
      },

      background = {
        bg = "#191726",
      },
      tab = {
        bg = "#191726",
      },

      buffer_selected = {
        fg = "#00ffff",
      },
      buffer_visible = {
        fg = "#ff00ff",
      },

      modified_selected = {
        fg = "#00ffff",
      },

      offset_separator = {
        fg = "#00ffff",
      },

      pick_selected = {
        fg = "#00ffff",
      },

      indicator_selected = {
        fg = "#00ffff",
      },

      hint_selected = {
        fg = "#00ffff",
        sp = "#00ffff",
      },

      warning = {
        bg = "#191726",
      },
      warning_selected = {
        fg = "#00ffff",
      },
      warning_visible = {
        fg = "#ff00ff",
      },
      warning_diagnostic = {
        bg = "#191726",
      },

      warning_diagnostic_selected = {
        fg = "#fede5d",
        sp = "#fede5d",
      },
      -- warning_diagnostic_visible = {
      --   fg = "#ffefae",
      -- },
      diagnostic_selected = {
        fg = "#fede5d",
      },
      -- diagnostic_visible = {
      --   fg = "#ffefae",
      -- },
      hint_diagnostic_selected = {
        fg = "#fede5d",
      },
      -- hint_diagnostic_visible = {
      --   fg = "#ffefae",
      -- },
      info_diagnostic_selected = {
        fg = "#fede5d",
      },
      -- info_diagnostic_visible = {
      --   fg = "#ffefae",
      -- },

      error_visible = {
        fg = "#ff00ff",
      },
      error_selected = {
        fg = "#00ffff",
      },

      tab_close = {
        bg = "#191726",
      },
      close_button = {
        bg = "#191726",
      },
      close_button_visible = {
        bg = "#2a2139",
      },
      close_button_selected = {
        bg = "#2a2139",
        fg = "#00ffff",
      },
      numbers_selected = {
        bg = "#2a2139",
        fg = "#00ffff",
      },

      separator = {
        fg = "#463465",
        bg = "#191726",
      },
      tab_separator = {
        fg = "#463465",
        bg = "#191726",
      },
      tab_separator_selected = {
        bg = "#2a2139",
        fg = "#00ffff",
        -- underline = "#00ffff",
      },
      separator_selected = {
        bg = "#2a2139",
        fg = "#00ffff",
      },
      separator_visible = {
        bg = "#2a2139",
        fg = "#00ffff",
      },
    },
  },

  config = function(_, opts)
    require("bufferline").setup(opts)

    vim.keymap.set({ "n", "v" }, "<leader>bn", "<cmd>BufferLineMoveNext<cr>", { desc = "Buffer Move Next" })
    vim.keymap.set({ "n", "v" }, "<leader>bp", "<cmd>BufferLineMovePrev<cr>", { desc = "Buffer Move Prev" })
    vim.keymap.set({ "n", "v" }, "<leader>bo", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer" })
    vim.keymap.set({ "n", "v" }, "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick Buffer to Close" })

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
