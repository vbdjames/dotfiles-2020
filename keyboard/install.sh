# disable caps lock
defaults -currentHost write -g com.apple.keyboard.modifiermapping.1452-601-0  -array \
    '<dict><key>HIDKeyboardModifierMappingDst</key><integer>-1</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>' \

# remap caps lock to 80
/Applications/Seil.app/Contents/Library/bin/seil set keycode_capslock 80
/Applications/Seil.app/Contents/Library/bin/seil set enable_capslock 1

# setup the private.xml file for Karabiner
if [ ! -d "$HOME/Library/Application Support/Karabiner/" ]
then
    mkdir "$HOME/Library/Application Support/Karabiner"
fi

ln -sf ~/.dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml
/Applications/Karabiner.app/Contents/Library/bin/karabiner reloadxml
/Applications/Karabiner.app/Contents/Library/bin/karabiner enable private.f192f19_escape
