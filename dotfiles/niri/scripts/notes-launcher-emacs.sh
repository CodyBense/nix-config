#!/usr/bin/env bash

DIR=$HOME/org

new_notes() {
    new_options=$(printf "daily\nnotes\nprojects" | rofi -dmenu -p "Notes: ") || exit 0
    case "$new_options" in
    "daily")
        touch $DIR/daily/$(command date +"%Y-%m-%d").org
        emacsclient -n $DIR/daily/$(command date +"%Y-%m-%d").org
        ;;
    *)
        # notify-send "Figure out how you want to implement new none daily notes"
        ;;
    esac
}
choice=$(printf "sync\nopen\nnew" | rofi -dmenu -p "Notes menu: ") || exit 0
case $choice in
"sync")
    rsync -rtu $HOME/org/* cody@vault:/data/org && rsync -rtu cody@vault:/data/org $HOME/
    noctalia-shell ipc call toast send '{"title": "Syncing org is complete"}'
    ;;
"open")
    note_dir=$(printf "$(command ls -t1 $DIR/roam/Notes)" | rofi -dmenu -p "Note dir: ") || exit 0
    echo $note_dir
    emacsclient -n $DIR/roam/Notes/$note_dir
    ;;
"new")
    new_notes
    ;;
"*")
    exit 1
    ;;
esac
