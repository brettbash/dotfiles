return {
  "echasnovski/mini.files",
  keys = {
    {
      "<leader>fm",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        require("beepboop").play_audio("patup")
      end,
      desc = "Open mini.files (Directory of Current File)",
    },
    {
      "<leader>fM",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
        require("beepboop").play_audio("patdown")
      end,
      desc = "Open mini.files (cwd)",
    },
  },
}
