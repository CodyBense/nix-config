#!/usr/bin/env bash
set -eu

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
    kitty --session "$HOME"/nix-config/launch.kitty-session &
    emacsclient -n "$HOME"/nix-config
    ;;
*)
    kitty --title "$options" --session "$DIR"/"$options"/launch.kitty-session &
    emacsclient -n $DIR/$options
    ;;
esac
