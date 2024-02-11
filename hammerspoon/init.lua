-- 🔨🥄
-- It's Hammer Time!
Hyper = { "cmd", "alt", "ctrl" }
Quantum = { "shift", "cmd", "alt", "ctrl" }
Bind = { "cmd", "alt" }
Whopper = { "cmd", "alt", "shift" }

-- Reload Config
hs.hotkey.bind(Hyper, "f1", function()
	hs.reload()
end)
hs.alert.show("おめでとう Config Loaded! 🏄 🌊")
require("window")
require("summon")
