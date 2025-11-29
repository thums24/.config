-- Focus specific applications with keyboard shortcuts
-- Alt+B for browser
hs.hotkey.bind({ "alt" }, "b", function()
	hs.application.launchOrFocus("Firefox") -- Change to your browser
end)

-- Alt+T for terminal
hs.hotkey.bind({ "alt" }, "t", function()
	hs.application.launchOrFocus("Ghostty") -- Change to your terminal
end)

-- Alt+M for Music
hs.hotkey.bind({ "alt" }, "m", function()
	hs.application.launchOrFocus("Music") -- Change to your terminal
end)

-- Alt+F for Figma
hs.hotkey.bind({ "alt" }, "f", function()
	hs.application.launchOrFocus("Figma") -- Change to your terminal
end)

-- Alt+S for Slack
hs.hotkey.bind({ "alt" }, "s", function()
	hs.application.launchOrFocus("Slack") -- Change to your terminal
end)
