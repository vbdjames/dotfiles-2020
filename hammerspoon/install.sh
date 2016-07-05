osascript<<END
tell application "System Events"
   if (login item "Hammerspoon" exists) is false then
      make login item at end with properties { path:"/Applications/Hammerspoon.app", name:"Hammerspoon", hidden:false }
   end if
end tell
END
defaults write org.hammerspoon.Hammerspoon MJShowDockIconKey -int 0
