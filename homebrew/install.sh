#!/bin/sh
#
# Homebrew

if test ! $(which brew)
then
    echo "  Installing Homebrew"
    curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
fi

exit 0
