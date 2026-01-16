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
other_projects="new\ndotfiles"
options=$(printf "${other_projects}\n$(ls $DIR)\n" | rofi -dmenu -p "Projects: ")

case "${options}" in
    "dotfiles")
        kitty --title "$options" --app-id project --directory $HOME/dotfiles zellij a -c dotfiles &
        emacsclient -c $HOME/dotfiles/
        ;;
    "new")
        project_name="$(printf '' | rofi -dmenu -p 'Project Name: ')"
        [ -n "$project_name" ] || exit 0
        echo $DIR/$project_name
        mkdir -p $DIR/$project_name
        kitty --title "$options" --app-id project --directory $DIR/$project_name zellij a -c $project_name &
        emacsclient -c $DIR/$project_name
        ;;
    *)
        # kitty --title "$options" --app-id project --directory $DIR/$options zellij a -c $options &
        # emacsclient -c $DIR/$options
        session_name="$(check_project_session $options)"
        if [[ session_name == "" ]]; then
            echo "It is not a session"
            # kitty --title "$options" --app-id project --directory $DIR/$options zellij attach $options &
        else
            echo "It is a session"
            # kitty --title "$options" --app-id project --directory $DIR/$options zellij --session $options &
        fi
        ;;
esac
