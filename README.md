# dotfiles

Your dotfiles are how you personalize your system. These are mine.

## topical

Everything's built around topic areas. If you're adding a new area to your
dotfiles - say "Java" - you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script\bootstrap`.

## components

There are a few special files in the hierarchy:

- **bin/**": Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew](brew.sh) to install:
  things like ...
- **topic/*.zsh**: Any files ending in `.zsh` get loaded into your environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is expected
  to set up `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded last and 
  is expected to to set up autocomplete.
- **topic/*.symlink**: Any files ending in `.symlink` get symlinked into your
  `$HOME`. This is so you can keep all of those versioned in your dotfiles, but
  still keep these autoloaded files in your home directory. These get symlinked
  in when you run `script/bootstrap`.

## pre-install

- Install OS X
- Install Xcode
- `xcode-select --install`
- `sudo xcodebuild -license` and agree to license
- Restore ssh keys and localrc
- Log in to the Mac App Store

## install

Run this:

```sh
mas login _username_ _password_
git clone https://github.com/vbdjames/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

`dot` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

TODO: what else do we need to do here - talk about adding new topic areas,
what about new dotfiles, etc.

## post-install

- Launch Hammerspoon
- Launch 1Password: set up sync.
- Launch Dropbox: log in and get the sync started, perhaps selectively
- Launch Alfred: change the launch key and locale and install the powerpack.
- Launch System Preferences -> Security & Privacy -> Privacy -> Accessibility: enable Keyboard Maestro, Hammerspoon, Karabiner, Alfred, Cheatsheet, and DropBox.
- Launch Chrome: log in, let it link to 1Password, and install the Pinboard plugin.
- Launch Safari: let it link to 1Password, and install the Pinboard plugin.
- Launch Spotify: log in.
- Launch Finder: add Home to favorites and remove All My Files from favorites.
- Launch Slack: set up teams (757dev, codeforva, friendshipismagical)
- Launch IntelliJ: register with JetBrains account, configure Settings Repository (https://github.com/vbdjames/intellij-settings), install plugins (IdeaVim, Relative Line Number, JRebel for IntelliJ), go into Preferences and Activate JRebel
- Launch nvALT:ange Read notes from folder: ~/Dropbox/Notes
- TODO: how to deliver music to the new laptop?
- TODO: how to manage VMs

## thanks

Modeled heavily on [Zach Holman](http://github.com/holman)'s [dotfiles](http://github.com/holman/dotfiles). 
