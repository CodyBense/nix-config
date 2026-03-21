#!/usr/bin/env bash

DIR=$HOME/workspaces/github/CodyBense

kitty --app-id project-launch --directory ~/workspaces/github/CodyBense -o font_features=none -e bash -c "ls | tv dirs >/tmp/project-selection"
project=$(cat /tmp/project-selection)
kitty --title "$project" --session "$HOME"/nix-config/dotfiles/kitty/sessions/project.kitty-session -d "$DIR"/"$project" &
sleep 0.5
emacsclient -n "$DIR"/"$project"
