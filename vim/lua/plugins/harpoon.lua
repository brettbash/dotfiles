return {
  "theprimeagen/harpoon",
  name = "harpoon",
  keys = {
    {
      "<leader>l",
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      desc = "Harpoon Add File",
    },

    {
      "<C-r>",
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      desc = "Harpoon Menu",
    },

    {
      "<C-n>",
      "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
      desc = "Harpoon 1",
    },

    {
      "<C-e>",
      "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
      desc = "Harpoon 2",
    },

    {
      "<C-i>",
      "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
      desc = "Harpoon 3",
    },

    {
      "<C-o>",
      "<cmd>lua require('harpoon').ui.nav_file(4)<cr>",
      desc = "Harpoon 4",
    },

    {
      "<leader>fh",
      "<cmd>Telescope harpoon marks<cr>",
      desc = "Harpoon Menu",
    },
  },
}
