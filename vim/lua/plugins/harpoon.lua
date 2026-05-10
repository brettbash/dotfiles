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
      "<cmd>Grapple toggle_tags<cr><cmd>lua require('beepboop').play('klink')<cr>",
      desc = "Harpoon",
    },
  },

  config = function()
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
        require("beepboop").play("dot")
        require("beepboop").play("waifu")
      end, { desc = "Harpoon Hook 󰛢" .. letter })

      vim.keymap.set("n", "<leader>j" .. letter, function()
        require("grapple").select({ name = letter })
        require("beepboop").play("hitap")
        require("beepboop").play("scorpion")
      end, { desc = "Harpoon Jump 󰯈 " .. letter })
    end
  end,
}
