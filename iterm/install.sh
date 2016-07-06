dest=~/Library/Preferences/com.googlecode.iterm2.plist
plb=/usr/libexec/PlistBuddy
cd "$(dirname "$0")"
script_path=$(pwd -P)

if [[ $(ps aux | grep "[i]Term.app") ]]; then
    echo "Please quit iTerm before running this script"
    exit 1
fi

if [ ! -f $dest ]; then
    echo "iTerm has to be started and shut down before options can be set."
    open /Applications/iTerm.app
    echo "After iTerm starts, please make a change to the default profile,"
    echo "then exit normally, and press return to continue."
    read dummy
fi

exists () {
    if [[ $($plb -c "Print $1" $dest 2>/dev/null) == '' ]]; then
        return 1 # yes, in bash, 1 = false
    else
        return 0 # and 0 = true
    fi
}

add_or_set () {
    if exists $1; then
        $plb -c "Set $1 $3" $dest
    else
        $plb -c "Add $1 $2 $3" $dest
    fi
}

add_or_set "PromptOnQuit" bool false
add_or_set "UseCompactLabel" bool false


if ! exists "Custom\ Color\ Presets"; then
  $plb -c "Add :Custom\ Color\ Presets dict" $dest
fi

if ! exists "Custom\ Color\ Presets:Solarized\ Light"; then
    $plb -c "Merge $script_path/solarized-light.plist  Custom\ Color\ Presets" $dest
fi

if ! exists "Custom\ Color\ Presets:Solarized\ Dark"; then
    $plb -c "Merge $script_path/solarized-dark.plist  Custom\ Color\ Presets" $dest
fi

if ! exists "Custom\ Color\ Presets:IR\ Black"; then
    $plb -c "Merge $script_path/ir-black.plist  Custom\ Color\ Presets" $dest
fi

default_guid=$(defaults read com.googlecode.iterm2 "Default Bookmark Guid")
bookmark_count=$(defaults read com.googlecode.iterm2 "New Bookmarks" | grep "Guid =" | wc -l)

for ((idx=0; idx < $bookmark_count; idx++)) 
do
    this_guid=$($plb -c "Print New\ Bookmarks:$idx:Guid" $dest)
    if [[ $this_guid == $default_guid ]]; then
        # set all the colors from Solarized Dark
        for ac in $(seq 0 15) 
        do
            $plb -c "Delete :New\ Bookmarks:$idx:Ansi\ $ac\ Color" $dest
            $plb -c "Copy :Custom\ Color\ Presets:Solarized\ Dark:Ansi\ $ac\ Color :New\ Bookmarks:$idx:Ansi\ $ac\ Color" $dest
        done

        $plb -c "Delete :New\ Bookmarks:$idx:Background\ Color" $dest
        $plb -c "Copy :Custom\ Color\ Presets:Solarized\ Dark:Background\ Color :New\ Bookmarks:$idx:Background\ Color" $dest

        $plb -c "Delete :New\ Bookmarks:$idx:Bold\ Color" $dest
        $plb -c "Copy :Custom\ Color\ Presets:Solarized\ Dark:Bold\ Color :New\ Bookmarks:$idx:Bold\ Color" $dest

        $plb -c "Delete :New\ Bookmarks:$idx:Cursor\ Color" $dest
        $plb -c "Copy :Custom\ Color\ Presets:Solarized\ Dark:Cursor\ Color :New\ Bookmarks:$idx:Cursor\ Color" $dest

        $plb -c "Delete :New\ Bookmarks:$idx:Cursor\ Text\ Color" $dest
        $plb -c "Copy :Custom\ Color\ Presets:Solarized\ Dark:Cursor\ Text\ Color :New\ Bookmarks:$idx:Cursor\ Text\ Color" $dest

        $plb -c "Delete :New\ Bookmarks:$idx:Foreground\ Color" $dest
        $plb -c "Copy :Custom\ Color\ Presets:Solarized\ Dark:Foreground\ Color :New\ Bookmarks:$idx:Foreground\ Color" $dest

        $plb -c "Delete :New\ Bookmarks:$idx:Selected\ Text\ Color" $dest
        $plb -c "Copy :Custom\ Color\ Presets:Solarized\ Dark:Selected\ Text\ Color :New\ Bookmarks:$idx:Selected\ Text\ Color" $dest

        $plb -c "Delete :New\ Bookmarks:$idx:Selection\ Color" $dest
        $plb -c "Copy :Custom\ Color\ Presets:Solarized\ Dark:Selection\ Color :New\ Bookmarks:$idx:Selection\ Color" $dest

        $plb -c "Set :New\ Bookmarks:$idx:Use\ Bold\ Font 0" $dest
        $plb -c "Set :New\ Bookmarks:$idx:Use\ Bright\ Bold 0" $dest
        $plb -c "Set :New\ Bookmarks:$idx:Normal\ Font SourceCodePro-Regular\ 15" $dest
        $plb -c "Set :New\ Bookmarks:$idx:Non\ Ascii\ Font SourceCodePro-Regular\ 15" $dest

        if exists ":New\ Bookmarks:$idx:Minimum\ Contrast"; then
            $plb -c "Set :New\ Bookmarks:$idx:Minimum\ Contrast 0.25" $dest
        else
            $plb -c "Add :New\ Bookmarks:$idx:Minimum\ Contrast real 0.25" $dest
        fi
    fi
done

