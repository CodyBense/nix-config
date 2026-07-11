#!/usr/bin/env bash

DIR=$HOME/workspaces/github/CodyBense

kitty --app-id project-launch --directory ~/workspaces/github/CodyBense -o font_features=none -e bash -c "ls | tv dirs > /tmp/project-selection"
project=$(cat /tmp/project-selection)

# project=$(kitty --app-id project-launch --directory ~/workspaces/github/CodyBense -o font_features=none -e bash -c "ls | tv dirs > /tmp/project-selection")
kitty --title "$project" --directory ~/workspaces/github/CodyBense/"$project" -e bash -c "zellij attach -c $project --layout ~/nix-config/dotfiles/zellij/layout/project.kdl "
