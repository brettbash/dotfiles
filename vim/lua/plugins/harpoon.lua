-- 󰆧 Lament Configuration 󰛢 󰯈  --
-- We have such sights to show you --
-- 󰫣 --
return {
  "cbochs/grapple.nvim",
  name = "harpoon",
  opts = {
    scope = "git",
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = "Grapple",
  keys = {
    { "<leader>j", "", desc = "Harpoon Jump 󰯈 " },
    { "<leader>h", "", desc = "Harpoon Hook 󰛢" },
    {
      "<leader>N",
      "<cmd>Grapple toggle_tags<cr><cmd>lua require('beepboop').play_audio('klink')<cr>",
      desc = "Harpoon",
    },
  },

  config = function()
    require("lualine").setup({
      sections = {
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
          "grapple",
        },
      },
    })

    require("grapple").setup({
      statusline = {
        icon = "󰛢 ───  ",
        active = "[󰯈 %s]",
        inactive = " %s ",
      },
    })

    local alphabet = "abcdefghijklmnopqrstuvwxyz"
    for i = 1, #alphabet do
      local letter = alphabet:sub(i, i)

      vim.keymap.set("n", "<leader>h" .. letter, function()
        require("grapple").tag({ name = letter })
        require("beepboop").play_audio("dot")
      end, { desc = "Harpoon Hook 󰛢" .. letter })

      vim.keymap.set("n", "<leader>j" .. letter, function()
        require("grapple").select({ name = letter })
        require("beepboop").play_audio("hitap")
      end, { desc = "Harpoon Jump 󰯈 " .. letter })
    end
  end,
}
