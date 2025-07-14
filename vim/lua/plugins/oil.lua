return {
  "echasnovski/mini.files",
  opts = function(_, opts)
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowOpen",
      callback = function(args)
        local win_id = args.data.win_id

        -- Customize window-local settings
        local config = vim.api.nvim_win_get_config(win_id)
        config.border = "rounded" -- Set the border style
        vim.api.nvim_win_set_config(win_id, config)
      end,
    })

    opts.custom_keymaps = {
      open_tmux_pane = "<M-t>",
      copy_to_clipboard = "<space>yy",
      zip_and_copy = "<space>yz",
      paste_from_clipboard = "<space>p",
      copy_path = "<M-c>",
      preview_image = "<space>i",
      preview_image_popup = "<M-i>",
    }

    opts.windows = vim.tbl_deep_extend("force", opts.windows or {}, {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    })

    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      use_as_default_explorer = true,
      permanent_delete = false,
    })
    return opts
  end,
  keys = {
    {
      "<leader>fm",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        require("beepboop").play_audio("patup")
      end,
      desc = "Open Oil (Directory of Current File)",
    },
    {
      "<leader>fM",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
        require("beepboop").play_audio("patdown")
      end,
      desc = "Open Oil (cwd)",
    },
  },
}
