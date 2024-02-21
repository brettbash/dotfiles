-- 󰆧 Lament Configuration 󰛢 󰯈  --
-- We have such sights to show you --
-- 󰫣 --
return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  name = "harpoon",

  config = function()
    require("lualine").setup({
      sections = {
        lualine_x = {
          {
            function()
              local key = require("grapple").key()
              return "󰛢---->> [󰯈 " .. key .. "]"
            end,
            cond = require("grapple").exists,
          },
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    })
    require("telescope").load_extension("grapple")
    -- vim.keymap.set("n", "<leader>j", function()
    --   require("grapple").select({ key = "{name}" })
    -- end, { desc = "Harpoon Select" })
  end,

  keys = {
    {
      "<leader>m",
      "<cmd>lua require('grapple').toggle()<cr>",
      desc = "Harpoon Hook",
    },

    {
      "<C-r>",
      "<cmd>lua require('grapple').popup_tags()<cr>",
      desc = "Harpoon Menu",
    },

    {
      "<leader>fh",
      "<cmd>Telescope grapple tags<cr>",
      desc = "Harpoon Telescope Menu",
    },

    {
      "<leader>j1",
      "<cmd>lua require('grapple').select({ key = 1 })<cr>",
      desc = "Harpoon Select 1",
    },

    {
      "<leader>j2",
      "<cmd>lua require('grapple').select({ key = 2 })<cr>",
      desc = "Harpoon Select 2",
    },

    {
      "<leader>j3",
      "<cmd>lua require('grapple').select({ key = 3 })<cr>",
      desc = "Harpoon Select 3",
    },

    {
      "<leader>j4",
      "<cmd>lua require('grapple').select({ key = 4 })<cr>",
      desc = "Harpoon Select 4",
    },

    {
      "<leader>j5",
      "<cmd>lua require('grapple').select({ key = 5 })<cr>",
      desc = "Harpoon Select 5",
    },

    {
      "<leader>j6",
      "<cmd>lua require('grapple').select({ key = 6 })<cr>",
      desc = "Harpoon Select 6",
    },
  },
}
