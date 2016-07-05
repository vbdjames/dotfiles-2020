-- TODO: need to map hot key to print planner page in taskpaper
--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------

-- Keyboard modifiers, Capslock bound to cmd+alt+ctrl+shift via Seil and Karabiner
local ctrl_alt = {"ctrl", "alt"}
local ctrl_alt_cmd = {"ctrl", "alt", "cmd"}
local hyper = {"ctrl", "alt", "cmd", "shift"}

-- Screens at the office
local laptop_screen = "Color LCD"
local dell_2309 = "DELL S2309W"
local viewsonic_926 = "VA926 Series"

-- Applications
local bitbucket = "Bitbucket"
local calendar = "Calendar"
local dash = "Dash"
local fromscratch = "FromScratch"
local intellij = "IntelliJ IDEA"
local iterm = "iTerm"
local itunes = "iTunes"
local jenkins = "Jenkins"
local jira = "JIRA"
local mail = "Mail"
local mapwiki = "Wiki"
local nvalt = "nvALT"
local safari = "Safari"
local sqldeveloper = "SQL Developer"
local taskpaper = "TaskPaper"
local windowsvm = "Windows7"

local mapcomCoding = {
    {
        name = { nvalt },
        func = function(index, win)
            win:moveToScreen(hs.screen.find(laptop_screen))
            win:maximize()
        end
    },
    {
        name = { bitbucket, calendar, dash, iterm, 
            itunes, jenkins, jira, mail, mapwiki, safari, 
            sqldeveloper, taskpaper },
        func = function(index, win)
            win:moveToScreen(hs.screen.find(viewsonic_926))
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
            win:moveToScreen(hs.screen.find(dell_2309))
            win:maximize()
        end
    }
}

--------------------------------------------------------------------------------
-- CONFIGURATION
--------------------------------------------------------------------------------
hs.window.animationDuration = 0 -- disable animations

--------------------------------------------------------------------------------
-- MISC HOTKEYS
--------------------------------------------------------------------------------
hs.hotkey.bind(hyper, 'r', function() hs.reload() end )
hs.hotkey.bind(hyper, 'y', function() hs.toggleConsole() end )

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

hs.hotkey.bind(ctrl_alt_cmd, "p", function()
    if (hs.itunes.isRunning()) then
        hs.itunes.playpause()
    end
end)

hs.hotkey.bind(ctrl_alt_cmd, "k", function()
    if (hs.itunes.isRunning()) then
        hs.itunes.next()
    end
end)

-- open apps
hs.hotkey.bind(hyper, "7", function() open(windowsvm) end )
hs.hotkey.bind(hyper, "b", function() open(bitbucket) end )
hs.hotkey.bind(hyper, "f", function() open(fromscratch) end )
hs.hotkey.bind(hyper, "i", function() open(intellij) end )
hs.hotkey.bind(hyper, "j", function() open(jira) end )
hs.hotkey.bind(hyper, "k", function() open(jenkins) end )
hs.hotkey.bind(hyper, "m", function() open(mail) end )
hs.hotkey.bind(hyper, "n", function() open(nvalt) end )
hs.hotkey.bind(hyper, "q", function() open(sqldeveloper) end )
hs.hotkey.bind(hyper, "s", function() open(safari) end )
hs.hotkey.bind(hyper, "t", function() open(iterm) end )
hs.hotkey.bind(hyper, "w", function() open(mapwiki) end )
hs.hotkey.bind(hyper, "u", function() open(itunes) end )

function open(appName)
    if (appName == windowsvm) then
        local win7 = hs.appfinder.appFromWindowTitlePattern(windowsvm)
        if (win7) then
            win7:activate()
        else
            os.execute("/usr/local/bin/VBoxManage startvm " .. windowsvm)
        end
        return true;
    else
        hs.application.open(appName)
    end
end

function kill(appName)
    if (appName == windowsvm) then
        local win7 = hs.appfinder.appFromWindowTitlePattern(windowsvm)
        if (win7) then
            win7:activate()
            os.execute("/usr/local/bin/VBoxManage controlvm " .. windowsvm .. " acpipowerbutton")
        else
            print("could not find app " .. appName)
        end
    else
        local app = hs.application.find(appName)
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
    local apps = { windowsvm, bitbucket, calendar, dash, 
        intellij, iterm, jenkins, jira, mail, mapwiki, 
        nvalt, safari, sqldeveloper, taskpaper }
    for i, v in ipairs(apps) do
        open(v)
    end
    hs.application.open(os.getenv("HOME") .. "/.bin/programming-playlist-paused.app");

    function areAllOpen()
        for i, v in ipairs(apps) do
            if (hs.application.find(v) == nil) then
                print("all are NOT open")
                return false
            end
        end
        print("all are open")
        return true
    end

    -- function foo()
    --     applyLayouts(mapcomCoding)
    -- end

    hs.timer.waitUntil(areAllOpen, function() applyLayouts(mapcomCoding) end)

    -- set up iterm tabs/tmux sessions/...
    -- start a new dailyrx for today if doesn't exist, else focus todays
    -- launch appropriate layout for morning - but we have to wait intil all the apps 
    -- finish launching before we apply the layout
end

function endWork()
    hs.alert.show("Shutting down work applications")
    local closeApps = { windowsvm, bitbucket, calendar, dash, 
        intellij, iterm, itunes, jenkins, jira, mail, mapwiki, 
        nvalt, safari, sqldeveloper, taskpaper }
    for i, v in ipairs(closeApps) do
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
                local app = hs.application.find(appName)
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
            local app = hs.application.find(layout.name)
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

hs.hotkey.bind(hyper, "3", function()
    applyLayouts(mapcomCoding)
end)

    
    
    
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

hs.hotkey.bind(hyper, "D", function()
    openToday()
end)
