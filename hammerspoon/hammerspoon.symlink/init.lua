config = {}
hyper = require('hyper')
hyper.start(config)

movewindows = require('movewindows')
movewindows.start()

local ctrl_alt = {"ctrl", "alt"}
local ctrl_alt_cmd = {"ctrl", "alt", "cmd"}

-- move to left half screen
hs.hotkey.bind(ctrl_alt, "Left", function() 
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- move to right half screen
hs.hotkey.bind(ctrl_alt, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- move to top half screen
hs.hotkey.bind(ctrl_alt, "Up", function() 
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)

-- move to bottom half screen
hs.hotkey.bind(ctrl_alt, "Down", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)

-- move to center
hs.hotkey.bind(ctrl_alt, "Space", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w / 6)
    f.y = max.y + (max.h / 6)
    f.w = max.w * 2 / 3
    f.h = max.h * 2 / 3
    win:setFrame(f)
end)

-- throw left
hs.hotkey.bind(ctrl_alt_cmd, "Left", function()
    local win = hs.window.focusedWindow()
    win:moveOneScreenWest()
    win:maximize()
end)

-- throw right
hs.hotkey.bind(ctrl_alt_cmd, "Right", function()
    local win = hs.window.focusedWindow()
    win:moveOneScreenEast()
    win:maximize()
end)

-- maximize
hs.hotkey.bind(ctrl_alt_cmd, "Space", function()
    local win = hs.window.focusedWindow()
    win:maximize()
end)















hyper:bind({}, 'r', nil, function()
    hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon')
end)
hyper:bind({'shift'}, 'r', nil, function() hs.reload() end)

