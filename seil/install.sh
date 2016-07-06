osascript<<END
tell application "System Events"
  if (login item "Seil" exists) is false then
    make login item at end with properties { path:"/Applications/Seil.app", name:"Seil", hidden:false }
  end if
end tell
END
