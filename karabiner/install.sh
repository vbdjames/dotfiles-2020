osascript<<END
tell application "System Events"
  if (login item "Karabiner" exists) is false then
    make login item at end with properties { path:"/Applications/Karabiner.app", name:"Karabiner", hidden:false }
  end if
end tell
END
