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
- **Brewfile**: This is a list of applications for [Homebrew][] to install:
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

## install

Run this:

```sh
git clone https://github.com/vbdjames/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaksed withing `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

TODO: what else do we need to do here - talk about adding new topic areas,
what about new dotfiles, etc.

## thanks

Modeled heavily on [Zach Holman][http://github.com/holman]'s [dotfiles][http://github.com/holman/dotfiles]. 
