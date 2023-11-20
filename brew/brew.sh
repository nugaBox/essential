#!/usr/bin/env bash

if ! which brew
then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

read -r -s -p "[sudo] sudo password for $(whoami):" pass
brew bundle --file=./common.Brewfile
echo "$pass" | sudo -S xattr -dr com.apple.quarantine /Applications/Docker.app
echo "$pass" | sudo -S xattr -dr com.apple.quarantine /Applications/iTerm.app
echo "$pass" | sudo -S xattr -dr com.apple.quarantine /Applications/Google\ Chrome.app
echo "$pass" | sudo -S xattr -dr com.apple.quarantine /Applications/Zeplin.app
echo "$pass" | sudo -S xattr -dr com.apple.quarantine /Applications/Slack.app
printf '\n\n🎉 Congrat! Your mac has been set up successfully for working with NUGABOX!\n'