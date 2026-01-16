#!/usr/bin/env bash
set -eu

DIR=$HOME/workspaces/github/CodyBense
other_projects="new\ndotfiles\ntest-scripts"
options=$(printf "${other_projects}\n$(ls $DIR)\n" | rofi -dmenu -p "Projects: ")

case "${options}" in
    "dotfiles")
        # ghostty --class="com.project.ghostty" --title="$options" --working-directory=$HOME/dotfiles -e zellij a -c dotfiles
        kitty --title "$options" --app-id project --directory $HOME/dotfiles zellij a -c dotfiles
        ;;
    "test-scripts")
        # ghostty --class="com.project.ghostty" --title="$options" --working-directory=$HOME/workspaces/projects/test-scripts/ -e zellij a -c test-scripts
        kitty --title "$options" --app-id project --directory $HOME/workspaces/projects/test-scripts/ zellij a -c test-scripts
        ;;
    "new")
        project_name="$(printf '' | rofi -dmenu -p 'Project Name: ')"
        [ -n "$project_name" ] || exit 0
        echo $DIR/$project_name
        mkdir -p $DIR/$project_name
        # ghostty --class="com.project.ghostty" --title="$options" --working-directory=$DIR/$project_name -e zellij a -c $project_name
        kitty --title "$options" --app-id project --directory $DIR/$project_name zellij a -c $project_name
        ;;
    *)
        # ghostty --class="com.project.ghostty" --title="$options" --working-directory=$DIR/$options -e zellij a -c $options
        kitty --title "$options" --app-id project --directory $DIR/$options zellij a -c $options
        ;;
esac
