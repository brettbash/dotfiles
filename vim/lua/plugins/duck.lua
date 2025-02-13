return {
  "tamton-aquib/duck.nvim",
  config = function()
    vim.keymap.set("n", "<leader>D", "", { desc = "Duck 🦆" })

    vim.keymap.set("n", "<leader>Dg", function()
      require("duck").hatch("👻", 10)
    end, { desc = "Spawn a Ghost 👻" })

    vim.keymap.set("n", "<leader>Ds", function()
      require("duck").hatch("🦑", 15)
    end, { desc = "Summon the Kraken 🦑" })

    vim.keymap.set("n", "<leader>Dc", function()
      require("duck").hatch("🐙", 20)
    end, { desc = "Summon the Cthulhu 🐙" })

    vim.keymap.set("n", "<leader>Dd", function()
      require("duck").hatch("🦆", 10)
    end, { desc = "Hatch a Duck 🦆" })

    vim.keymap.set("n", "<leader>Dd", function()
      require("duck").hatch("🐉", 30)
    end, { desc = "Call the Dragon 🐉" })

    vim.keymap.set("n", "<leader>Dk", function()
      require("duck").cook()
    end, { desc = "Kill Kill Kill" })

    vim.keymap.set("n", "<leader>Da", function()
      require("duck").cook_all()
    end, { desc = "Kill 'em All" })
  end,
}
