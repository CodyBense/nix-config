#!/usr/bin/env bash

check_project_session() {
    local session_name=""
    zellij list-sessions | grep "$1"
    if [[ $? == 0 ]]; then
        session_name=$(zellij list-sessions | grep "$1" | cut --delimiter ' ' --field 1)
    fi
    echo "$session_name"
}

DIR=$HOME/workspaces/github/CodyBense
other_projects="nix-config\n"
options=$(printf "${other_projects}\n$(ls $DIR)\n" | rofi -dmenu -p "Projects: ")

case "${options}" in
nix-config)
    kitty --session "$HOME"/nix-config/project.kitty-session -d ~/nix-config &
    emacsclient -n "$HOME"/nix-config
    ;;
*)
    kitty --title "$options" --session "$HOME"/nix-config/dotfiles/kitty/sessions/project.kitty-session -d "$DIR"/"$options" &
    emacsclient -n $DIR/$options
    ;;
esac
