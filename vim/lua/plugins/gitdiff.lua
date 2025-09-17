return {
  "nvim-mini/mini.diff",
  event = "VeryLazy",
  opts = {
    view = {
      style = "sign",
      signs = {
        add = " │",
        change = " │",
        delete = " ",
      },
    },
  },
}
