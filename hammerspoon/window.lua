-- local hs = require("hs") -- Uncomment only for editing this file.

hs.grid.setMargins(hs.geometry.size(0, 0))
hs.grid.setGrid("8x4")

local function setWindowGrid(key, gridSettings, Modifier)
	hs.hotkey.bind(Modifier or Bind, key, function()
		local win = hs.window.focusedWindow()
		hs.grid.set(win, gridSettings)
	end)
end

-- 1/4
-- ## Top
setWindowGrid(";", "0,0 2x2") -- Left
setWindowGrid("'", "2,0 2x2") -- 25%
setWindowGrid("a", "4,0 2x2") -- 75%
setWindowGrid("r", "6,0 2x2") -- Right
-- ## Full Height
setWindowGrid("s", "0,0 2x4") -- Left
setWindowGrid("t", "2,0 2x4") -- 25%
setWindowGrid("g", "4,0 2x4") -- 75%
setWindowGrid("m", "6,0 2x4") -- Right
-- ## Bottom
setWindowGrid("n", "0,2 2x2") -- Left
setWindowGrid("e", "2,2 2x2") -- 25%
setWindowGrid("i", "4,2 2x2") -- 75%
setWindowGrid("o", "6,2 2x2") -- Right

-- 3/4
-- ## Top
setWindowGrid("z", "0,0 6x2") -- Left
setWindowGrid("x", "1,0 6x2") -- Center
setWindowGrid("c", "2,0 6x2") -- Right
-- ## Full Height
setWindowGrid("k", "0,0 6x4") -- Left 3/4
setWindowGrid("h", "1,0 6x4") -- Center
setWindowGrid(",", "2,0 6x4") -- Right
-- ## Bottom
setWindowGrid("f12", "0,2 6x2") -- Left
setWindowGrid("f11", "1,2 6x2") -- Center
setWindowGrid("f10", "2,2 6x2") -- Right

-- 1/3
-- ## Top
setWindowGrid("f9", "0,0 2.6666666667x2") -- Left
setWindowGrid("f8", "2.6666666666,0 2.6666666667x2") -- Center
setWindowGrid("f7", "5.3333333334,0 2.6666666667x2") -- Right
-- ## Full Height
setWindowGrid("f6", "0,0 2.6666666667x4") -- Left
setWindowGrid("f5", "2.6666666666,0 2.6666666667x4") -- Center
setWindowGrid("f4", "5.3333333334,0 2.6666666667x4") -- Right
-- ## Bottom
setWindowGrid("f3", "0,2 2.6666666667x2") -- Left
setWindowGrid("f2", "2.6666666666,2 2.6666666667x2") -- Center
setWindowGrid("f1", "5.3333333334,2 2.6666666667x2") -- Right

-- 2/3
-- ## Top
setWindowGrid("f13", "0,0 5.3333333334x2") -- Left
setWindowGrid("f14", "1.3333333333,0 5.3333333334x2") -- Center
setWindowGrid("f15", "2.6666666666,0 5.3333333334x2") -- Right
-- ## Full Height
setWindowGrid("f16", "0,0 5.3333333334x4") -- Left
setWindowGrid("f17", "1.3333333333,0 5.3333333334x4") -- Center
setWindowGrid("f18", "2.6666666666,0 5.3333333334x4") -- Right
-- ## Bottom
setWindowGrid("f19", "0,2 5.3333333334x2") -- Left
setWindowGrid("f20", "1.3333333333,2 5.3333333334x2") -- Center
setWindowGrid("f20", "2.6666666666,2 5.3333333334x2", Whopper) -- Right

-- 1/2
-- ## Top
setWindowGrid("q", "0,0 4x2") -- Left
setWindowGrid("w", "2,0 4x2") -- Center
setWindowGrid("f", "4,0 4x2") -- Right
-- ## Full Height
setWindowGrid("p", "0,0 4x4") -- Left
setWindowGrid("b", "2,0 4x4") -- Center
setWindowGrid("j", "4,0 4x4") -- Right
-- ## Bottom
setWindowGrid("l", "0,2 4x2") -- Left
setWindowGrid("u", "2,2 4x2") -- Center
setWindowGrid("y", "4,2 4x2") -- Right

-- Browser Sizes
setWindowGrid("1", "1.422,0.558 5.16x2.886") -- Browser Large
setWindowGrid("2", "1.015,0.558 5.975x2.886") -- Browser Large with Sidebar
setWindowGrid("3", "0.25,0.558 5.16x2.886") -- Browser Large Left (used with 0)
setWindowGrid("4", "1.739,0.558 4.522x2.886") -- 3xl Breakpoint
setWindowGrid("5", "1.94,0.69 4.14x2.63") -- 2xl Breakpoint
setWindowGrid("6", "2.278,0.91 3.46x2.2") -- xl Breakpoint
setWindowGrid("7", "2.62,1.06 2.779x1.865") -- lg Breakpoint
setWindowGrid("8", "2.95,0.68 2.098x2.65") -- md Breakpoint
setWindowGrid("9", "3.13,0.905 1.7555x2.214") -- sm Breakpoint

setWindowGrid("-", "3.38,0.82 1.25x2.355") -- Phone

setWindowGrid("0", "5.6,1.09 1.25x2.355") -- Phone Right (used with 4)

-- Max Size
setWindowGrid(".", "0,0 8x4")

-- Fullscreen
hs.hotkey.bind(Hyper, "\\", function()
	hs.window.focusedWindow():toggleFullScreen()
end)

-- Center
hs.hotkey.bind({ "alt", "cmd" }, "/", function()
	hs.window.focusedWindow():centerOnScreen()
end)

-- Move Between Displays
hs.hotkey.bind(Hyper, "right", function()
	local win = hs.window.focusedWindow()
	local next = win:screen():toEast()
	if next then
		win:moveToScreen(next, true)
	end
end)

hs.hotkey.bind(Hyper, "left", function()
	local win = hs.window.focusedWindow()
	local next = win:screen():toWest()
	if next then
		win:moveToScreen(next, true)
	end
end)

hs.hotkey.bind(Hyper, "up", function()
	local win = hs.window.focusedWindow()
	local next = win:screen():toNorth()
	if next then
		win:moveToScreen(next, true)
	end
end)

hs.hotkey.bind(Hyper, "down", function()
	local win = hs.window.focusedWindow()
	local next = win:screen():toSouth()
	if next then
		win:moveToScreen(next, true)
	end
end)

-- Show the Grid
hs.hotkey.bind(Hyper, "f20", function()
	hs.grid.show()
end)
