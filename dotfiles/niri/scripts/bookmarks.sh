#!/usr/bin/env bash

bookmark=$(cat $HOME/.local/share/bookmarks.txt | cut --delimiter ',' --fields 1 | rofi -dmenu -p "bookmarks: ") || exit 0

case "$bookmark" in
    *)
        zen-browser --new-window "$(cat $HOME/.local/share/bookmarks.txt | grep "$bookmark" | cut --delimiter ',' --fields 2)"
        ;;
esac
