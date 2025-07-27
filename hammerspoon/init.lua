-- Focus specific applications with keyboard shortcuts

-- Alt+B for browser
hs.hotkey.bind({ "alt" }, "b", function()
	hs.application.launchOrFocus("Zen") -- Change to your browser
end)

-- Alt+T for terminal
hs.hotkey.bind({ "alt" }, "t", function()
	hs.application.launchOrFocus("kitty") -- Change to your terminal
end)
