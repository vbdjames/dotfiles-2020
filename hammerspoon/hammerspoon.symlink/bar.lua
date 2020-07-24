-- TODO: manage laptop display resolution automatically
-- TODO: manage volume, including starting quiet at work, when not headphones
--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------

-- Keyboard modifiers, Capslock bound to F18 via karabiner-elements
k = hs.hotkey.modal.new({}, "F17")

pressedF18 = function()
  k.triggered = false
  k:enter()
end

releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

local ctrl_alt = {"ctrl", "alt"}
local ctrl_alt_cmd = {"ctrl", "alt", "cmd"}

-- Screens at the office
--
local laptop_screen = "Color LCD"
local dell_2309 = "DELL S2309W"
local viewsonic = "CDE3203"

-- Applications
local bear = "net.shinyfrog.Bear"
local bitbucket = "com.fluidapp.FluidApp.Bitbucket"
local calendar = "com.apple.iCal"
local dash = "com.kapeli.dash"
local eclipse = "org.eclipse.platform.ide"
local fromscratch = "com.electron.fromscratch"
local hipchat = "com.hipchat.HipChat"
local intellij = "com.jetbrains.intellij"
local iterm = "com.googlecode.iterm2"
-- local terminal = "com.apple.terminal"
local jenkins = "com.fluidapp.FluidApp.Jenkins"
local jira = "com.fluidapp.FluidApp.JIRA"
local kindle = "com.amazon.Kindle"
local mail = "com.apple.mail"
local mapwiki = "com.fluidapp.FluidApp.Wiki"
-- local nvalt = "net.elasticthreads.nv"
local safari = "com.apple.Safari"
local spotify = "com.spotify.client"
local sqldeveloper = "com.oracle.SQLDeveloper"
local mapcomclient = "mapcomClient"
local wunderlist = "com.wunderkinder.wunderlistdesktop"

local mapcomCoding = {
    {
        name = { hipchat, bear, spotify, wunderlist, calendar },
        func = function(index, win)
            win:moveToScreen(hs.screen.find(laptop_screen))
            win:maximize()
            if index ~= 1 then
                win:application():hide()
            end
        end
    },
    {
        name = { bitbucket, dash, iterm, 
            jenkins, jira, mail, mapwiki, safari, 
            sqldeveloper },
        func = function(index, win)
            win:moveToScreen(hs.screen.find(dell_2309))
            win:maximize()
            win:application():hide()
        end
    },
    {
        name = { "VirtualBox VM" },
        func = function(index, win)
            win:application():hide()
        end
    },
    {
        name = { intellij },
        func = function(index, win)
            win:moveToScreen(hs.screen.find(viewsonic))
            win:maximize()
        end
    }
}

--------------------------------------------------------------------------------
-- CONFIGURATION
--------------------------------------------------------------------------------
hs.window.animationDuration = 0 -- disable animations
hs.application.enableSpotlightForNameSearches(true)

--------------------------------------------------------------------------------
-- MISC HOTKEYS
--------------------------------------------------------------------------------
k:bind({}, 'r', function() hs.reload(); k:exit(); end)
k:bind({}, 'y', function() hs.toggleConsole(); k:exit(); end)

--------------------------------------------------------------------------------
-- METHODS
--------------------------------------------------------------------------------
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end


--------------------------------------------------------------------------------
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

-- spotify
hs.hotkey.bind(ctrl_alt_cmd, "p", function()
    if (hs.spotify.isRunning()) then
        hs.spotify.playpause()
    end
end)

hs.hotkey.bind(ctrl_alt_cmd, "k", function()
    if (hs.spotify.isRunning()) then
        hs.spotify.next()
    end
end)

hs.hotkey.bind(ctrl_alt_cmd, "t", function()
    if (hs.spotify.isRunning()) then
        hs.spotify.displayCurrentTrack()
    end
end)

-- open apps
apps = {
    {'a', kindle},
    {'b', bitbucket},
    {'c', mapcomclient},
    -- d
    {'e', eclipse},
    {'f', fromscratch},
    -- g
    {'h', hipchat},
    {'i', intellij},
    {'j', jira},
    {'k', jenkins},
    -- l
    {'m', mail},
    {'n', bear},
    -- o
    -- p
    {'q', sqldeveloper},
    -- r
    {'s', safari},
    {'t', iterm},
    {'u', wunderlist},
    -- v
    {'w', mapwiki}
    -- x
    -- y
    -- z
}

for i, app in ipairs(apps) do
    k:bind({}, app[1], function() open(app[2]); k:exit(); end)
end

function open(appName, hide)
    hide = hide or false
    if (appName == mapcomclient) then
        local mapclient = hs.appfinder.appFromWindowTitlePattern(mapcomclient)
        if (mapclient) then
            mapclient:activate()
        else
            os.execute("/usr/local/bin/VBoxManage startvm " .. mapcomclient)
        end
        return true;
    else
        local app = hs.application.get(appName)
        if (app) then
            app:activate()
        else
            hs.application.open(appName)
        end
    end
end

function kill(appName)
    if (appName == mapcomclient) then
        os.execute("/usr/local/bin/VBoxManage controlvm " .. mapcomclient .. " acpipowerbutton")
    else
        local app = hs.application.get(appName)
        if (app) then
            app:activate()
            app:kill()
        else
            print("could not find app " .. appName)
        end
    end
end


function beginWork()
    hs.alert.show("Opening work applications")
    local apps = { bitbucket, calendar, dash, hipchat, 
        intellij, iterm, jenkins, jira, mail, mapwiki, 
        bear, safari, wunderlist, spotify, sqldeveloper }
    for i, v in ipairs(apps) do
        open(v)
    end
    hs.applescript('tell application "Spotify" to play track "spotify:track:2pnJ87yTVpkgtZh6Tq4vKh" in context "spotify:user:johanbrook:playlist:2mtlhuFVOFMn6Ho3JmrLc2"')
    hs.spotify.pause()


    -- set up terminal tabs/tmux sessions/...
    -- start a new dailyrx for today if doesn't exist, else focus todays
    -- launch appropriate layout for morning - but we have to wait intil all the apps 
    -- finish launching before we apply the layout
end

function endWork()
    hs.alert.show("Shutting down work applications")
    local closeApps = { safari, mapcomclient, bitbucket, calendar, dash, hipchat,
        intellij, iterm, jenkins, jira, mail, mapwiki, 
        nvalt, wunderlist, spotify, sqldeveloper }
    for i, v in ipairs(closeApps) do
        print(v)
        kill(v)
    end
    hs.execute("diskutil unmount '/Volumes/Time Machine'")
end

hs.urlevent.bind("beginwork", beginWork)
hs.urlevent.bind("endwork", endWork)


-- coding config (3-monitor)
    -- nvalt maximized left
    -- intellij maximized center
    -- might want to look at sqldeveloper (on right)
    -- might want to look at safari (on right)

local mapcomTesting = {

}

function applyLayouts(layouts)
    print("applying layout")
    for i, layout in ipairs(layouts) do
        if (type(layout.name) == "table") then
            for i, appName in ipairs(layout.name) do
                local app = hs.application.get(appName)
                if (app) then
                    local wins = app:allWindows()
                    local counter = 1
                    for j, win in ipairs(wins) do
                        if (win:isVisible() and layout.func) then
                            layout.func(counter, win)
                            counter = counter + 1
                        end
                    end
                end
            end
        elseif (type(layout.name) == "string") then
            local app = hs.application.get(layout.name)
            if (app) then
                local wins = app:allWindows()
                local counter = 1
                for j, win in ipairs(wins) do
                    if (win:isVisible() and layout.func) then
                        layout.func(counter, win)
                        counter = counter + 1
                    end
                end
            end
        end
    end
end

k:bind({}, '3', function() applyLayouts(mapcomCoding); k:exit(); end)
    
    -- testing config (3-monitor)
    -- windows or testapp on big monitor
    -- nvalt on left
    -- might want sqldeveloper on left
    -- usually watching jboss on right
-- admin config
    -- mail
    -- calendar
    -- safari or chrome
local PreviousPowerSource = hs.battery.powerSource()
hs.battery.watcher.new(function()
    CurrentPowerSource = hs.battery.powerSource()
    if CurrentPowerSource ~= PreviousPowerSource then
        if CurrentPowerSource == "Battery Power" then
            hs.alert.show("ejecting disks")
            hs.execute("diskutil unmount '/Volumes/Time Machine'")
        end
        PreviousPowerSource = CurrentPowerSource
    end
end):start()


-- we have to reference the absolute path, because pathwatcher
-- does not notice changes in the target of a symbolic link
hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon", reloadConfig):start()
hs.alert.show("Config loaded")

function openToday()
    local nvaltNotesPath = os.getenv("HOME") .. "/Dropbox/Notes/"
    local app = hs.application.open(nvalt)

    function getTitle(date)
        if (date == nil) then 
            date = os.date("*t") 
        end
        return "dailyx - " .. os.date("%Y-%m-%d", os.time(date))
    end

    function getPath(title)
        return nvaltNotesPath .. title .. ".md"
    end

    local title = getTitle()
    local uriTitle = hs.http.encodeForQuery(title)
    local filepath = getPath(title)

    function fileExists()
        return hs.fs.attributes(filepath) ~= nil
    end

    if (hs.fs.attributes(filepath) == nil) then
        local today = os.date("*t");
        local d = os.date("*t")
        repeat
            d.day = d.day - 1
            copyPath = getPath(getTitle(d))
            if (hs.fs.attributes(copyPath) ~= nil) then
                os.execute("cp '" .. copyPath .. "' '" .. filepath .. "'")
                break
            end
        until (today.day - d.day > 20)
    end

    -- seems we can't just hit the nvalt url scheme (nvalt://find/uriTitle)
    hs.timer.waitUntil(fileExists, function()
        app:selectMenuItem({"Note", "Search or Create…"})
        hs.eventtap.keyStrokes(title .. "\r")
    end)


end

k:bind({}, 'd', function() openToday(); k:exit(); end)
